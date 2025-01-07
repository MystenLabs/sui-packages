module 0x9b23b8fdd142118a250d6402bf08d3d580bbb1c211641840250be57292846988::suiwolff {
    struct SUIWOLFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWOLFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWOLFF>(arg0, 6, b"SUIWOLFF", b"WOLF SUI", b"The prettiest and most loyal dog of $Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_14_204012247_5aadb3372a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWOLFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWOLFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

