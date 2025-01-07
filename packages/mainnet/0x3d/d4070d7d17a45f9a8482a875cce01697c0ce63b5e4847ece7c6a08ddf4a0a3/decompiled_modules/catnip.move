module 0x3dd4070d7d17a45f9a8482a875cce01697c0ce63b5e4847ece7c6a08ddf4a0a3::catnip {
    struct CATNIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATNIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATNIP>(arg0, 6, b"CATNIP", b"Catnip", b"We are Nipped. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241227_021745_114_d6c03751ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATNIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATNIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

