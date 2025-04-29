module 0xf7eaa4c0fc7f3f607d34ee32b93b671f73b31081785f716b32a2c68213225c82::puggy {
    struct PUGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGGY>(arg0, 6, b"PUGGY", b"PUGGYDOG", b"THIS IS PUGGY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih6jdhm62vgyeazgrye57px2frqour6jxlgxaeuqn6g4shs7gcgm4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUGGY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

