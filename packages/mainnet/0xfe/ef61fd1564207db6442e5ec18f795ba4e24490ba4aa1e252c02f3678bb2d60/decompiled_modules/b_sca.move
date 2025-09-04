module 0xfeef61fd1564207db6442e5ec18f795ba4e24490ba4aa1e252c02f3678bb2d60::b_sca {
    struct B_SCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SCA>(arg0, 9, b"bSCA", b"bToken SCA", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

