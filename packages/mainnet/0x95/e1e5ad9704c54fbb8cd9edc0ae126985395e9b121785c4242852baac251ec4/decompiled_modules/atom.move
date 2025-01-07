module 0x95e1e5ad9704c54fbb8cd9edc0ae126985395e9b121785c4242852baac251ec4::atom {
    struct ATOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATOM>(arg0, 6, b"ATOM", b"AtomWeb.at", b"Get ATOM Airdrop  visiting url: www.AtomWeb.at  - https://AtomWeb.at", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_64beb28256.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

