module 0x5d3f6f429fcd81a04c7fca6ec29b9a146e4c880d2b8951b1bf47ce6675409924::suirise {
    struct SUIRISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRISE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIRISE>(arg0, 6, b"SUIRISE", b"SUIRISE  by SuiAI", b"Community driven movement that believes in the rise of Sui network. We create, inspire, and lead the charge towarda future powered by Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/SUIRISE_c5c7e234e9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIRISE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRISE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

