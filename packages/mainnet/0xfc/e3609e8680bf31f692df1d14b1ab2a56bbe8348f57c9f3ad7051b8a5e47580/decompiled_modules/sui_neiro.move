module 0xfce3609e8680bf31f692df1d14b1ab2a56bbe8348f57c9f3ad7051b8a5e47580::sui_neiro {
    struct SUI_NEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_NEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_NEIRO>(arg0, 9, b"Sui Neiro", b"SUINEIRO", b"0x5e0da3ab5ad35707d9a78456bcff63f5355c59798359877287decd03c8c1c1e5::neiro::NEIRO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0x5e0da3ab5ad35707d9a78456bcff63f5355c59798359877287decd03c8c1c1e5::neiro::neiro.png?size=xl&key=588a88")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_NEIRO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_NEIRO>>(v2, @0xb24420dbd7948eb723f055df1eac2706ea24f75c7b37a3d494fd6a8969e89025);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_NEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

