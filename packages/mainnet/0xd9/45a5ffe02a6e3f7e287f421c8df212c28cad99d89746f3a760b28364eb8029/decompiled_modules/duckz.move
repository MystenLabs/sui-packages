module 0xd945a5ffe02a6e3f7e287f421c8df212c28cad99d89746f3a760b28364eb8029::duckz {
    struct DUCKZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKZ>(arg0, 6, b"DUCKZ", b"SuiDuckz", b"Building Together Sui Ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730955623171.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUCKZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

