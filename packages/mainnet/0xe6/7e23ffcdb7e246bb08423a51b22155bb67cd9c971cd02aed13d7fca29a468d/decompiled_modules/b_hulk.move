module 0xe67e23ffcdb7e246bb08423a51b22155bb67cd9c971cd02aed13d7fca29a468d::b_hulk {
    struct B_HULK has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_HULK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_HULK>(arg0, 9, b"bHULK", b"bToken HULK", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_HULK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_HULK>>(v1);
    }

    // decompiled from Move bytecode v6
}

