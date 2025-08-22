module 0xb576ad45da185d7081a5ebd557e44ff7f3034f18d2c6ad6d3bcb296a91c1cb0d::b_xaum {
    struct B_XAUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_XAUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_XAUM>(arg0, 9, b"bXAUM", b"bToken XAUM", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_XAUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_XAUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

