module 0xe822845cfac8cb7de37198ff5b0ffcddfd61c46257a289f454ea4a60dffccc02::ctcap {
    struct CTCAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTCAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTCAP>(arg0, 6, b"CTCAP", b"CALTYCAP", b"Fueled by the strength and unity of its community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicmlr7d6lza2erhucirkdd3wcmibyghyzgkskqmyecsxtyyetomji")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTCAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CTCAP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

