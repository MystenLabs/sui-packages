module 0x6ac47d7fcff560165ed383ad7d6ffcf8b8b472c965622b152a46a80a58a5fea0::justpole {
    struct JUSTPOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUSTPOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUSTPOLE>(arg0, 6, b"JustPOLE", b"Pole Only", b"Polar Bear on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_6068948055681515464_c_b96b6a81e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUSTPOLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUSTPOLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

