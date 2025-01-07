module 0x817437eabe44d7f924e5feb16976fa64a39a80ea700f18e6398a3c1f885cded9::lesson1 {
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

    public fun PlaceMarks(arg0: &TeacherCap, arg1: address, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TeacherCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<TeacherCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

