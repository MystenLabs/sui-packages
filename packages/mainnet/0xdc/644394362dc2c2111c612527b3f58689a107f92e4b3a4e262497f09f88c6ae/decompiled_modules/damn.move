module 0xdc644394362dc2c2111c612527b3f58689a107f92e4b3a4e262497f09f88c6ae::damn {
    struct DAMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAMN>(arg0, 6, b"DAMN", b"DICKMAN", b"Damn I am Dickamn!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s_Pr_B7_Zk_E_400x400_b17807fa12.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

