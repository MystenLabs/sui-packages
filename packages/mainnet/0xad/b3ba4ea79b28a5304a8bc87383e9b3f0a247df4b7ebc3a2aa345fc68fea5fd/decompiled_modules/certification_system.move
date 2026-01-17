module 0xadb3ba4ea79b28a5304a8bc87383e9b3f0a247df4b7ebc3a2aa345fc68fea5fd::certification_system {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Diploma has store, key {
        id: 0x2::object::UID,
        student_name: 0x1::string::String,
        course_name: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun issue_diploma(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Diploma{
            id           : 0x2::object::new(arg4),
            student_name : arg1,
            course_name  : arg2,
        };
        0x2::transfer::public_transfer<Diploma>(v0, arg3);
    }

    // decompiled from Move bytecode v6
}

