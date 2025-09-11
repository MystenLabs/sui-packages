module 0x1c0d82caa0c99ebfd84572ad3b6dc80099a24d5d2dd812e8344d04e835e8fb80::academia_system {
    struct Student has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        email: 0x1::string::String,
        subjects: 0x2::vec_map::VecMap<u64, Grades>,
    }

    struct Grades has drop, store {
        name: 0x1::string::String,
        score: u16,
        approved: bool,
    }

    public fun add_student(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Student{
            id       : 0x2::object::new(arg0),
            name     : 0x1::string::utf8(b"Jesus Viloria"),
            email    : 0x1::string::utf8(b"viloriajep@gmail.com"),
            subjects : 0x2::vec_map::empty<u64, Grades>(),
        };
        0x2::transfer::transfer<Student>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun add_subjects(arg0: &mut Student, arg1: u64, arg2: 0x1::string::String, arg3: u16) {
        assert!(!0x2::vec_map::contains<u64, Grades>(&arg0.subjects, &arg1), 13906834457811222529);
        let v0 = arg3 > 5;
        let v1 = Grades{
            name     : arg2,
            score    : arg3,
            approved : v0,
        };
        0x2::vec_map::insert<u64, Grades>(&mut arg0.subjects, arg1, v1);
    }

    public fun delete_student(arg0: Student) {
        let Student {
            id       : v0,
            name     : _,
            email    : _,
            subjects : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun delete_subjects(arg0: &mut Student, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, Grades>(&arg0.subjects, &arg1), 13906834552300634115);
        let (_, _) = 0x2::vec_map::remove<u64, Grades>(&mut arg0.subjects, &arg1);
    }

    public fun sync_score(arg0: &mut Student, arg1: u64, arg2: u16) {
        assert!(0x2::vec_map::contains<u64, Grades>(&arg0.subjects, &arg1), 13906834599545274371);
        let v0 = 0x2::vec_map::get_mut<u64, Grades>(&mut arg0.subjects, &arg1);
        let v1 = arg2 > 5;
        v0.score = arg2;
        v0.approved = v1;
    }

    // decompiled from Move bytecode v6
}

