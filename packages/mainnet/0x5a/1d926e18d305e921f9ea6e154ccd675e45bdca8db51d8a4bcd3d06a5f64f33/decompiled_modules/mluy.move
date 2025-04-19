module 0x5a1d926e18d305e921f9ea6e154ccd675e45bdca8db51d8a4bcd3d06a5f64f33::mluy {
    struct MLUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MLUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MLUY>(arg0, 6, b"Mluy", b"Moon Fluffy", b"Born from stardust and marshmallow dreams, Moon Fluffy brings magic and sweetness to the SUI blockchain. First marshmallow token on moonbags , created by grok Ai on X.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib66cydfe77ua55jebjloqq4dko3ipcgb4iwqor27eh6spa6jyloa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MLUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MLUY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

