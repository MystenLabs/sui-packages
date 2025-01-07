module 0x9f79d716f4b2b4b43ee24b0b1e23f25d5e74aa5d7c3e7c54a4646ac7c54dc911::lesson1 {
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

    public entry fun add_additional_teacher(arg0: &TeacherCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = TeacherCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<TeacherCap>(v0, arg1);
    }

    public entry fun create_wrappable_transcript_object(arg0: &TeacherCap, arg1: u8, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = WrappableTranscript{
            id         : 0x2::object::new(arg4),
            history    : arg1,
            math       : arg2,
            literature : arg3,
        };
        0x2::transfer::transfer<WrappableTranscript>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun delete_transcript(arg0: &TeacherCap, arg1: WrappableTranscript) {
        let WrappableTranscript {
            id         : v0,
            history    : _,
            math       : _,
            literature : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TeacherCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<TeacherCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun request_transcript(arg0: WrappableTranscript, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Folder{
            id               : 0x2::object::new(arg2),
            transcript       : arg0,
            intended_address : arg1,
        };
        0x2::transfer::transfer<Folder>(v0, arg1);
    }

    public entry fun unpack_wrapped_transcript(arg0: Folder, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.intended_address == 0x2::tx_context::sender(arg1), 1);
        let Folder {
            id               : v0,
            transcript       : v1,
            intended_address : _,
        } = arg0;
        0x2::transfer::transfer<WrappableTranscript>(v1, 0x2::tx_context::sender(arg1));
        0x2::object::delete(v0);
    }

    public entry fun update_score(arg0: &TeacherCap, arg1: &mut WrappableTranscript, arg2: u8) {
        arg1.literature = arg2;
    }

    public fun view_score(arg0: &WrappableTranscript) : u8 {
        arg0.literature
    }

    // decompiled from Move bytecode v6
}

