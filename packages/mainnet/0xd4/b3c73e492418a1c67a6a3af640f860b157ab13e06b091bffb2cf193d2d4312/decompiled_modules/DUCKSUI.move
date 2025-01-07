module 0xd4b3c73e492418a1c67a6a3af640f860b157ab13e06b091bffb2cf193d2d4312::DUCKSUI {
    struct DUCKSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DUCKSUI>, arg1: 0x2::coin::Coin<DUCKSUI>) {
        0x2::coin::burn<DUCKSUI>(arg0, arg1);
    }

    fun init(arg0: DUCKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKSUI>(arg0, 9, b"SuiD", b"Duck Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/q5QTmS1/DUCKSUI.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUCKSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DUCKSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DUCKSUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

