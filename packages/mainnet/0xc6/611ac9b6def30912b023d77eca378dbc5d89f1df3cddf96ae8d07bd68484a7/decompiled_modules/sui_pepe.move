module 0xc6611ac9b6def30912b023d77eca378dbc5d89f1df3cddf96ae8d07bd68484a7::sui_pepe {
    struct SUI_PEPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUI_PEPE>, arg1: 0x2::coin::Coin<SUI_PEPE>) {
        0x2::coin::burn<SUI_PEPE>(arg0, arg1);
    }

    fun init(arg0: SUI_PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_PEPE>(arg0, 6, b"SPEPE", b"SUI PEPE", b"The biggest memecoin on SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sui-pepe.xyz/_next/static/media/logo.6e0d8f53.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_PEPE>>(v1);
        let v3 = &mut v2;
        mint(v3, 10000000000000000000, @0xf79844c606450d256c4edc03241d8327d5e240cc11f959251ca1982348606351, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUI_PEPE>>(v2);
    }

    fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUI_PEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUI_PEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

