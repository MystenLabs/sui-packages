module 0x41a3350004440adf89a2f837c1e4c0bf1fe4edf6e08b56383ccb5c1606f210c1::attendance {
    struct ATTENDANCE has drop {
        dummy_field: bool,
    }

    struct Attendance has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_id: 0x1::string::String,
        description: 0x1::string::String,
        tier: u8,
        meet_id: 0x2::object::ID,
    }

    struct AttendanceCreated has copy, drop {
        id: 0x2::object::ID,
        meet_id: 0x2::object::ID,
        tier: u8,
    }

    public(friend) fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) : Attendance {
        let v0 = Attendance{
            id          : 0x2::object::new(arg5),
            name        : arg0,
            image_id    : arg2,
            description : arg1,
            tier        : arg3,
            meet_id     : arg4,
        };
        let v1 = AttendanceCreated{
            id      : 0x2::object::uid_to_inner(&v0.id),
            meet_id : arg4,
            tier    : arg3,
        };
        0x2::event::emit<AttendanceCreated>(v1);
        v0
    }

    public fun id(arg0: &Attendance) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: ATTENDANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui Developer Relations Team"));
        let v4 = 0x2::package::claim<ATTENDANCE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Attendance>(&v4, v0, v2, arg1);
        0x2::display::update_version<Attendance>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Attendance>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint_and_transfer(arg0: &mut 0x41a3350004440adf89a2f837c1e4c0bf1fe4edf6e08b56383ccb5c1606f210c1::meet::Meet, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Attendance>(new(arg1, arg2, arg3, arg4, 0x41a3350004440adf89a2f837c1e4c0bf1fe4edf6e08b56383ccb5c1606f210c1::meet::id(arg0), arg6), arg5);
    }

    public fun name(arg0: &Attendance) : 0x1::string::String {
        arg0.name
    }

    public fun receive<T0: store + key>(arg0: &mut Attendance, arg1: 0x2::transfer::Receiving<T0>) : T0 {
        0x2::transfer::public_receive<T0>(&mut arg0.id, arg1)
    }

    public fun tier(arg0: &Attendance) : u8 {
        arg0.tier
    }

    // decompiled from Move bytecode v6
}

