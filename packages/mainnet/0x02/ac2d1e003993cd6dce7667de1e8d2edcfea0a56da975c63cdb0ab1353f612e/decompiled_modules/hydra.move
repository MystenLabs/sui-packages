module 0x2ac2d1e003993cd6dce7667de1e8d2edcfea0a56da975c63cdb0ab1353f612e::hydra {
    struct HYDRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYDRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYDRA>(arg0, 6, b"HYDRA", b"HYDRANT", b"$HYDRA just turned the pressure all the way up. One HYDRANT. One STREAM. Endless GREEN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih4bmxlmptomqzxxq3oiiizjupoy3m3mgucf22q3znhaow7z5rdiy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYDRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HYDRA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

