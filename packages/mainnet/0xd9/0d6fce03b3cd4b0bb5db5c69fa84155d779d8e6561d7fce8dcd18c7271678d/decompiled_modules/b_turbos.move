module 0xd90d6fce03b3cd4b0bb5db5c69fa84155d779d8e6561d7fce8dcd18c7271678d::b_turbos {
    struct B_TURBOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TURBOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TURBOS>(arg0, 9, b"bTURBOS", b"bToken TURBOS", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TURBOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TURBOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

