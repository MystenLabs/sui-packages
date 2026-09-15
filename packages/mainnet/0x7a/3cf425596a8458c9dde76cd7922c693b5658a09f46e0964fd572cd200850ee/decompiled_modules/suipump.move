module 0x7a3cf425596a8458c9dde76cd7922c693b5658a09f46e0964fd572cd200850ee::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"034652590a465259204f4e20535549655769746820796f75722068656c702077652063616e206265206f6e65206f6620746865206265737420636f6d6d756e6974696573206f6e20537569217c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f4672794d656d65636f696e227d4d68747470733a2f2f7062732e7477696d672e636f6d2f70726f66696c655f696d616765732f313835363031353638383231383836313537302f59426c526862315a5f343030783430302e6a7067");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

