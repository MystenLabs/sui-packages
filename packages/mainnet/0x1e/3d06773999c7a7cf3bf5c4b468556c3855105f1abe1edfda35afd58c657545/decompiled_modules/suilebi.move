module 0x1e3d06773999c7a7cf3bf5c4b468556c3855105f1abe1edfda35afd58c657545::suilebi {
    struct SUILEBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILEBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILEBI>(arg0, 6, b"SUILEBI", b"Suilebi Pokemon Game", b"The first pokemon catch game on SuiNetwork .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif2o3kgjbad7dr5zhuqibmxh4z2rzklpkb272uzqa4ityn5xtb3ki")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILEBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUILEBI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

