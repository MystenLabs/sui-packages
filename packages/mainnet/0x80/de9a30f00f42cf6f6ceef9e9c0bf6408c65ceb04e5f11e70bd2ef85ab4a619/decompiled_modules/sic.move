module 0x80de9a30f00f42cf6f6ceef9e9c0bf6408c65ceb04e5f11e70bd2ef85ab4a619::sic {
    struct SIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIC>(arg0, 6, b"SIC", b"SIGMA CULT", b"SIGMA CULT ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fe83a02b_ba40_4fae_a34e_ba8dfceb7070_87284c86d8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

