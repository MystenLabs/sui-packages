module 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::receive {
    struct RECEIVE has drop {
        dummy_field: bool,
    }

    struct ReceiveSettings has key {
        id: 0x2::object::UID,
        fee: u64,
    }

    struct ReturnKioskOwnerCapPromise {
        pfp_id: 0x2::object::ID,
        kiosk_owner_cap_id: 0x2::object::ID,
    }

    struct ObjectReceivedEvent has copy, drop {
        pfp_id: 0x2::object::ID,
        received_object_id: 0x2::object::ID,
        received_object_type: 0x1::type_name::TypeName,
    }

    public fun receive<T0: store + key>(arg0: &mut 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory::PrimeMachin, arg1: 0x2::transfer::Receiving<T0>, arg2: 0x2::coin::Coin<0xa99166e802527eeb5439cbda12b0a02851bf2305d3c96a592b1440014fcb8975::koto::KOTO>, arg3: &ReceiveSettings) : T0 {
        assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::coloring::ColoringReceipt>(), 2);
        assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<0x2::kiosk::KioskOwnerCap>(), 2);
        assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<0xa99166e802527eeb5439cbda12b0a02851bf2305d3c96a592b1440014fcb8975::koto::KOTO>(), 2);
        assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::ImageChunk>(), 2);
        assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::RegisterImageChunkCap>(), 2);
        assert!(0x2::coin::value<0xa99166e802527eeb5439cbda12b0a02851bf2305d3c96a592b1440014fcb8975::koto::KOTO>(&arg2) == arg3.fee, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa99166e802527eeb5439cbda12b0a02851bf2305d3c96a592b1440014fcb8975::koto::KOTO>>(arg2, @0xde0053243f3226649701a7fe2c3988be11941bf3ff3535f3c8c5bf32fc600220);
        let v0 = 0x2::transfer::public_receive<T0>(0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory::uid_mut(arg0), arg1);
        let v1 = ObjectReceivedEvent{
            pfp_id               : 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory::id(arg0),
            received_object_id   : 0x2::object::id<T0>(&v0),
            received_object_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ObjectReceivedEvent>(v1);
        v0
    }

    public fun admin_set_receive_fee(arg0: &0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::admin::AdminCap, arg1: &mut ReceiveSettings, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::admin::verify_admin_cap(arg0, arg3);
        arg1.fee = arg2;
    }

    fun init(arg0: RECEIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ReceiveSettings{
            id  : 0x2::object::new(arg1),
            fee : 100,
        };
        0x2::transfer::share_object<ReceiveSettings>(v0);
    }

    public fun receive_kiosk_owner_cap(arg0: &mut 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory::PrimeMachin, arg1: 0x2::transfer::Receiving<0x2::kiosk::KioskOwnerCap>) : (0x2::kiosk::KioskOwnerCap, ReturnKioskOwnerCapPromise) {
        assert!(0x2::transfer::receiving_object_id<0x2::kiosk::KioskOwnerCap>(&arg1) == 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory::kiosk_owner_cap_id(arg0), 4);
        let v0 = 0x2::transfer::public_receive<0x2::kiosk::KioskOwnerCap>(0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory::uid_mut(arg0), arg1);
        let v1 = ReturnKioskOwnerCapPromise{
            pfp_id             : 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory::id(arg0),
            kiosk_owner_cap_id : 0x2::object::id<0x2::kiosk::KioskOwnerCap>(&v0),
        };
        (v0, v1)
    }

    public fun receive_koto(arg0: &mut 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory::PrimeMachin, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<0xa99166e802527eeb5439cbda12b0a02851bf2305d3c96a592b1440014fcb8975::koto::KOTO>>) : 0x2::coin::Coin<0xa99166e802527eeb5439cbda12b0a02851bf2305d3c96a592b1440014fcb8975::koto::KOTO> {
        0x2::transfer::public_receive<0x2::coin::Coin<0xa99166e802527eeb5439cbda12b0a02851bf2305d3c96a592b1440014fcb8975::koto::KOTO>>(0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory::uid_mut(arg0), arg1)
    }

    public fun return_kiosk_owner_cap(arg0: 0x2::kiosk::KioskOwnerCap, arg1: ReturnKioskOwnerCapPromise) {
        assert!(arg1.kiosk_owner_cap_id == 0x2::object::id<0x2::kiosk::KioskOwnerCap>(&arg0), 3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(arg0, 0x2::object::id_to_address(&arg1.pfp_id));
        let ReturnKioskOwnerCapPromise {
            pfp_id             : _,
            kiosk_owner_cap_id : _,
        } = arg1;
    }

    // decompiled from Move bytecode v6
}

