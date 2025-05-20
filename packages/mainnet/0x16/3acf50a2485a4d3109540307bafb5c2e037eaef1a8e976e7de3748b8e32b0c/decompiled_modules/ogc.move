module 0x163acf50a2485a4d3109540307bafb5c2e037eaef1a8e976e7de3748b8e32b0c::ogc {
    struct OGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGC>(arg0, 6, b"OGC", b"One Gay Coin", x"4f6e652047617920436f696e202d20546865206f6e6c7920636f696e20746861742070756d7073206173206861726420617320796f7520646f2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OGC_de55b3c410.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OGC>>(v1);
    }

    // decompiled from Move bytecode v6
}

