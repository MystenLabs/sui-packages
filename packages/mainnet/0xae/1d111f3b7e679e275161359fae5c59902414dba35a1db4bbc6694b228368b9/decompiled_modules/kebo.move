module 0xae1d111f3b7e679e275161359fae5c59902414dba35a1db4bbc6694b228368b9::kebo {
    struct KEBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEBO>(arg0, 6, b"KEBO", b"Kebo Dog", b"Kebo dog - Just fun memecoin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008752_4a94728757.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

