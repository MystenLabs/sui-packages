module 0x5a4f64079daed04d923c93f3ac4ee04b637e5b3ea2db87d591981c1049508a27::suilama {
    struct SUILAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILAMA>(arg0, 6, b"SUILAMA", b"Suilama", b"Solama the Official Unofficial Sui Mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030596_8a14750351.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

