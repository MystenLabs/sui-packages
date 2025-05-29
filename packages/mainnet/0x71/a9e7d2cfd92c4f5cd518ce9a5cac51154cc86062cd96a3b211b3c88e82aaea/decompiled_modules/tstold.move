module 0x71a9e7d2cfd92c4f5cd518ce9a5cac51154cc86062cd96a3b211b3c88e82aaea::tstold {
    struct TSTOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSTOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSTOLD>(arg0, 6, b"TSTOLD", b"TSTOLD Token", b"This is a token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxoqyrauo3po2milbl457qswcpzgdoju275mujji45tndpeej3ri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSTOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TSTOLD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

