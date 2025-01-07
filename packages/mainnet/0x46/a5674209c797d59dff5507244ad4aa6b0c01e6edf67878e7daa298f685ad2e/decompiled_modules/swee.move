module 0x46a5674209c797d59dff5507244ad4aa6b0c01e6edf67878e7daa298f685ad2e::swee {
    struct SWEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWEE>(arg0, 6, b"Swee", b"Swee ", b"It's pronounced SWEE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731251888325.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWEE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWEE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

