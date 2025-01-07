module 0xed973f4e9198dc9ea087344722e96e0e930a3bd5e5d7ea3896d16fe1f7990742::lesson1 {
    struct MarksObject has store, key {
        id: 0x2::object::UID,
        math: u8,
        phys: u8,
    }

    struct MarksObjectWrapper has key {
        id: 0x2::object::UID,
        marksObject: MarksObject,
        owner: address,
    }

    struct TeacherCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TeacherCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<TeacherCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun place_marks(arg0: &TeacherCap, arg1: address, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = MarksObject{
            id   : 0x2::object::new(arg4),
            math : arg2,
            phys : arg3,
        };
        0x2::transfer::transfer<MarksObject>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

