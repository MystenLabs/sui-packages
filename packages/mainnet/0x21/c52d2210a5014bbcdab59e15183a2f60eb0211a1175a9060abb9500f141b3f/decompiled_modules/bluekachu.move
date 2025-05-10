module 0x21c52d2210a5014bbcdab59e15183a2f60eb0211a1175a9060abb9500f141b3f::bluekachu {
    struct BLUEKACHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEKACHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEKACHU>(arg0, 6, b"BlueKachu", b"BlueKachu SUI", b"The first Bluekachu on Moonbags", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidivlxchtyscnnvzcoh652ioogmthxsjjx7xtuthhd3fasrwgynlm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEKACHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUEKACHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

