module 0x8783a193b7123ef2261283ba07fd68af9e8c5b0c31dfdd73de26f37834b60db8::mapo {
    struct MAPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAPO>(arg0, 6, b"MAPO", b"Mapo On Sui", b"The first Holders Bubble Map on the Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigvogdvh4lmahmeu65p634kuccrqjo7dgltawjq5zj7o3ylv2ttgm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MAPO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

