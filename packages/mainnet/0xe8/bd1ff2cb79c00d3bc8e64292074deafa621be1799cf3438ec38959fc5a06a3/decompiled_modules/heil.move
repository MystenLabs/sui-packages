module 0xe8bd1ff2cb79c00d3bc8e64292074deafa621be1799cf3438ec38959fc5a06a3::heil {
    struct HEIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEIL>(arg0, 6, b"HEIL", b"SuiElon", x"546865204d6f7374204f6666656e7369766520436f6d6d756e697479206f6e20537569200a0a4e6f20506f6c69746963616c20436f72726563746e6573730a4e6f20576f6b652043756c74757265200a4e6f2043656e736f72736869700a4e6f204c696d69740a4e6f20444549200a0a50757474696e67207468652045646765206261636b20696e20496e7465726e65742c0a4f6e652073686974706f737420617420612074696d652e20244845494c200a0a4a6f696e2074686520436f6d6d756e69747920746f646179206f6e2054656c656772616d21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/elonh_1_6bbc1af73b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

