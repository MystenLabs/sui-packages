module 0x68700a0d2346d2276321e8734c4c590ff7f82347d31ebbbb52ada640c86b8431::skinny {
    struct SKINNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKINNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKINNY>(arg0, 6, b"Skinny", b"SkinnyMelons", b"Skinny Melons is Token of one NFT Collection of 500 Unics NFTs ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/258_6a09db9c11.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKINNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKINNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

