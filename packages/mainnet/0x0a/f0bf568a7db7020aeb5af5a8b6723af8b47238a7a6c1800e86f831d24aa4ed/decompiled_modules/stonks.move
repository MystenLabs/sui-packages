module 0xaf0bf568a7db7020aeb5af5a8b6723af8b47238a7a6c1800e86f831d24aa4ed::stonks {
    struct STONKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STONKS>(arg0, 9, b"STONKS", b"suistonks", x"5765742053746f6e6b732c204869676865722052657475726e73210a47455420594f55522053544f4e4b53", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1729272812013-e49cce78367fa3bbe23ba768232a009b.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STONKS>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STONKS>>(v2, @0x701daa7a72b0d281039a2b819a4b6fb68b98acf9d888ac760e07b649da695d82);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STONKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

