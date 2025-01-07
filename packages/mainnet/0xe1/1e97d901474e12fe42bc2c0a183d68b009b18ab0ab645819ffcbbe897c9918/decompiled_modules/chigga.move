module 0xe11e97d901474e12fe42bc2c0a183d68b009b18ab0ab645819ffcbbe897c9918::chigga {
    struct CHIGGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIGGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIGGA>(arg0, 6, b"CHIGGA", b"Release my chigga", b"The only chigga on sui is in jail. lets help his release", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Chigga_Artwork_63baec8548.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIGGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIGGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

