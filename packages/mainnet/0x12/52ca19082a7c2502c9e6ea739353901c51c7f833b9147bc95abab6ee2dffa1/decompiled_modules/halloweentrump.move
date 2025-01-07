module 0x1252ca19082a7c2502c9e6ea739353901c51c7f833b9147bc95abab6ee2dffa1::halloweentrump {
    struct HALLOWEENTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALLOWEENTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALLOWEENTRUMP>(arg0, 6, b"HALLOWEENTRUMP", b"TRUMP OR TREAT", b"Trump or treat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BE_84_F55_C_7568_479_B_9_BF_7_F403_D9_E7_B294_2488da6ba8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALLOWEENTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HALLOWEENTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

