module 0xd34114483b7b228c0f14d4c2df7db9e7d0186ce300330d93746292590fb6fc26::mdif {
    struct MDIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDIF>(arg0, 6, b"MDIF", b"Moo Deng Wif Hat", b"A fan based meme coin for the world's most famous baby hippo, Moo Deng, but wif a hat!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000005919_5e43a5bc52.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MDIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

