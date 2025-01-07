module 0x2dd032c2389f157b5d05f99c84adbed22a78e34bba08e5560abdef0d694775e0::lesson1 {
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
        let v1 = MarksObjectWrapper{
            id          : 0x2::object::new(arg4),
            marksObject : v0,
            owner       : arg1,
        };
        0x2::transfer::transfer<MarksObjectWrapper>(v1, arg1);
    }

    // decompiled from Move bytecode v6
}

