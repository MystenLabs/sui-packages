module 0xfe6448f87dd8c01da53ed64caa596e350e00e6d3ab3916a86aac4c6fd3340199::suitable {
    struct SUITABLE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUITABLE>, arg1: 0x2::coin::Coin<SUITABLE>) {
        0x2::coin::burn<SUITABLE>(arg0, arg1);
    }

    fun init(arg0: SUITABLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITABLE>(arg0, 9, b"TABLE", b"SUITABLE", b"SUITABLE TG:https://t.me/tablesui", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITABLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITABLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUITABLE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUITABLE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

