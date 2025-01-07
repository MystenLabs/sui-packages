module 0x626da7bda3d95a2ad38b5700edfc171556ef61250d0107864c8e4805eb1f4003::bbl {
    struct BBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBL>(arg0, 6, b"BBL", b"Catbish", b"no hookups, not dtf unless you got money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_02_04_15_08_a89213faf5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

