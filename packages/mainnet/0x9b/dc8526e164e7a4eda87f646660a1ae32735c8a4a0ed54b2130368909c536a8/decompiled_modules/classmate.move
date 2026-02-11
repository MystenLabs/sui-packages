module 0x9bdc8526e164e7a4eda87f646660a1ae32735c8a4a0ed54b2130368909c536a8::classmate {
    struct Classroom has store, key {
        id: 0x2::object::UID,
        school: 0x1::string::String,
        class_name: 0x1::string::String,
        creator: address,
        member_count: u64,
    }

    struct Student has store, key {
        id: 0x2::object::UID,
        classroom_id: address,
        student_address: address,
        encrypted_name: vector<u8>,
        encrypted_student_id: vector<u8>,
        encrypted_contact: vector<u8>,
    }

    struct ClassroomCreated has copy, drop {
        classroom_id: address,
        creator: address,
        school: 0x1::string::String,
        class_name: 0x1::string::String,
    }

    struct StudentAdded has copy, drop {
        classroom_id: address,
        student_address: address,
    }

    public fun add_student(arg0: &mut Classroom, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id_address<Classroom>(arg0);
        let v1 = Student{
            id                   : 0x2::object::new(arg4),
            classroom_id         : v0,
            student_address      : 0x2::tx_context::sender(arg4),
            encrypted_name       : arg1,
            encrypted_student_id : arg2,
            encrypted_contact    : arg3,
        };
        arg0.member_count = arg0.member_count + 1;
        let v2 = StudentAdded{
            classroom_id    : v0,
            student_address : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<StudentAdded>(v2);
        0x2::transfer::share_object<Student>(v1);
    }

    public fun create_classroom(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Classroom{
            id           : 0x2::object::new(arg2),
            school       : arg0,
            class_name   : arg1,
            creator      : 0x2::tx_context::sender(arg2),
            member_count : 0,
        };
        let v1 = ClassroomCreated{
            classroom_id : 0x2::object::id_address<Classroom>(&v0),
            creator      : 0x2::tx_context::sender(arg2),
            school       : v0.school,
            class_name   : v0.class_name,
        };
        0x2::event::emit<ClassroomCreated>(v1);
        0x2::transfer::share_object<Classroom>(v0);
    }

    public fun get_class_name(arg0: &Classroom) : &0x1::string::String {
        &arg0.class_name
    }

    public fun get_creator(arg0: &Classroom) : address {
        arg0.creator
    }

    public fun get_member_count(arg0: &Classroom) : u64 {
        arg0.member_count
    }

    public fun get_school(arg0: &Classroom) : &0x1::string::String {
        &arg0.school
    }

    public fun get_student_address(arg0: &Student) : address {
        arg0.student_address
    }

    public fun get_student_classroom_id(arg0: &Student) : address {
        arg0.classroom_id
    }

    public fun get_student_info(arg0: &Student) : (vector<u8>, vector<u8>, vector<u8>) {
        (arg0.encrypted_name, arg0.encrypted_student_id, arg0.encrypted_contact)
    }

    // decompiled from Move bytecode v6
}

