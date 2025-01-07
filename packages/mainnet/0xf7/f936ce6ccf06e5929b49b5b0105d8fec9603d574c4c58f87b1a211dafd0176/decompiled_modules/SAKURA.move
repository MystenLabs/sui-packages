module 0xf7f936ce6ccf06e5929b49b5b0105d8fec9603d574c4c58f87b1a211dafd0176::SAKURA {
    struct SAKURA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SAKURA>, arg1: 0x2::coin::Coin<SAKURA>) {
        0x2::coin::burn<SAKURA>(arg0, arg1);
    }

    fun init(arg0: SAKURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAKURA>(arg0, 9, b"SKR", b"SAKURA", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/NFn1288/sakura.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAKURA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAKURA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SAKURA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SAKURA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

