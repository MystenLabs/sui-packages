module 0x68cc1c05b8d03f52cb66ae25cb91ec380d4eb1449094f9e5d20187cd9706e20c::hello_world {
    struct HelloWorldObject has store, key {
        id: 0x2::object::UID,
        text: 0x1::string::String,
    }

    struct WrappableTranscript has store, key {
        id: 0x2::object::UID,
        history: u8,
        math: u8,
        literature: u8,
    }

    struct Folder has key {
        id: 0x2::object::UID,
        transcript: WrappableTranscript,
        intended_address: address,
    }

    struct TeacherCap has key {
        id: 0x2::object::UID,
    }

    public fun create_wrappable_transcript(arg0: &TeacherCap, arg1: u8, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = WrappableTranscript{
            id         : 0x2::object::new(arg4),
            history    : arg1,
            math       : arg2,
            literature : arg3,
        };
        0x2::transfer::transfer<WrappableTranscript>(v0, 0x2::tx_context::sender(arg4));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TeacherCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<TeacherCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun request_transcript(arg0: WrappableTranscript, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Folder{
            id               : 0x2::object::new(arg2),
            transcript       : arg0,
            intended_address : arg1,
        };
        0x2::transfer::transfer<Folder>(v0, arg1);
    }

    public fun unpack_wrapped_transcript(arg0: Folder, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.intended_address, 0);
        let Folder {
            id               : v0,
            transcript       : v1,
            intended_address : _,
        } = arg0;
        0x2::transfer::transfer<WrappableTranscript>(v1, 0x2::tx_context::sender(arg1));
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

