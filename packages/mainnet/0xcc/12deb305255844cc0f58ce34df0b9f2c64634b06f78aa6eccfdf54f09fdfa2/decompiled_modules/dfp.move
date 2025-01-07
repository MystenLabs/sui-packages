module 0xcc12deb305255844cc0f58ce34df0b9f2c64634b06f78aa6eccfdf54f09fdfa2::dfp {
    struct DFP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFP>(arg0, 6, b"DFP", b"Durio-Fu Panda", b"The token was created to popularize durian and panda, we want our token to be cute like a panda.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726757300211_b4da56d3b5a9bf4e43bc1a69080c12cc_2385a3d570.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DFP>>(v1);
    }

    // decompiled from Move bytecode v6
}

