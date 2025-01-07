module 0xca8745ed28f6ec9a77433518167eda3ef81a3f748135db74c55ee46159c64357::btsu {
    struct BTSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTSU>(arg0, 9, b"BTSU", b"Bubble tea", b"Bubble tea Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.bubbleteasui.site/sui.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BTSU>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTSU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

