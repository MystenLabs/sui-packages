module 0x24787b635ce4e85e0e58aad572dbf84c4dd83c26f693fdebb59495f2b9a78c7b::lolg {
    struct LOLG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLG>(arg0, 6, b"LOLG", b"LOL Game", b"LOL token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid36uhwrftnvsbllqxmk6ucvrt7styzuqlymaqtxj5w5l4tibz2z4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOLG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

