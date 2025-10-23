module 0xf940a6b442fff99cfb5515ffa4bcf8d4041365dc2bd15fdb4d904b9dc7dd6789::b_nickel {
    struct B_NICKEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_NICKEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_NICKEL>(arg0, 9, b"bNICKEL", b"bToken NICKEL", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_NICKEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_NICKEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

