module 0x99d98c7b0b07b35b4de634d3b427f7c7f2af26c355ba3369f4918790dd568477::academy {
    struct Student has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        belt: 0x1::string::String,
        photo_blob_id: 0x1::string::String,
        wallet_address: address,
        created_at: u64,
    }

    struct Attendance has store, key {
        id: 0x2::object::UID,
        student_id: address,
        photo_blob_id: 0x1::string::String,
        timestamp: u64,
    }

    public fun create_student(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Student{
            id             : 0x2::object::new(arg3),
            name           : 0x1::string::utf8(arg0),
            belt           : 0x1::string::utf8(arg1),
            photo_blob_id  : 0x1::string::utf8(arg2),
            wallet_address : 0x2::tx_context::sender(arg3),
            created_at     : 0x2::tx_context::epoch(arg3),
        };
        0x2::transfer::transfer<Student>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun register_attendance(arg0: address, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Attendance{
            id            : 0x2::object::new(arg2),
            student_id    : arg0,
            photo_blob_id : 0x1::string::utf8(arg1),
            timestamp     : 0x2::tx_context::epoch(arg2),
        };
        0x2::transfer::transfer<Attendance>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

