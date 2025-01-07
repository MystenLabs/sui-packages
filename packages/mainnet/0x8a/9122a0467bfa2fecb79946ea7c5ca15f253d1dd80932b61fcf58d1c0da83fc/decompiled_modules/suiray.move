module 0x8a9122a0467bfa2fecb79946ea7c5ca15f253d1dd80932b61fcf58d1c0da83fc::suiray {
    struct SUIRAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRAY>(arg0, 6, b"SUIRAY", b"SUI RAY SMILING", b"Hi I'm Ray, the most friendly fish on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_12_15_12_02_48711ca4bc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

