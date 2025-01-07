module 0x426b64cbd729f8ccd6a723c2b2f8afe327de271f06320af98aae52cae6ec9d52::ftr {
    struct FTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTR>(arg0, 6, b"FTR", b"FREE TOMMY ROBinson", b"token leader", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_26_alle_16_15_29_390624fdd8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

