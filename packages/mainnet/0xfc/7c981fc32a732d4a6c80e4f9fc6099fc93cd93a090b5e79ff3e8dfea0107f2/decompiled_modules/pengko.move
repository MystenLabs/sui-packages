module 0xfc7c981fc32a732d4a6c80e4f9fc6099fc93cd93a090b5e79ff3e8dfea0107f2::pengko {
    struct PENGKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGKO>(arg0, 6, b"PENGKO", b"Pudgy Penguin Gecko", b"CoinGecko puts a fun twist on the NFT craze, blending two fan favoritesPudgy Penguins and their iconic green gecko. The result? A penguin rocking a gecko suit thats equal parts adorable and genius.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241217_201548_994_9ce6602ff8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

