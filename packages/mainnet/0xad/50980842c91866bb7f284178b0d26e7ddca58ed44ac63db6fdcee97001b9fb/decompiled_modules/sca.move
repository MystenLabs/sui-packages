module 0xad50980842c91866bb7f284178b0d26e7ddca58ed44ac63db6fdcee97001b9fb::sca {
    struct SCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCA>(arg0, 6, b"Sca", b"SCAM", b"THATS Scam JUST BUY ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/scam_watch_750x420_eaa7d8e609.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

