module 0x7a89b083d1c4fcf0c3e974123b716e88c53532c5eaec9daa9e6e7823debcb411::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEPE>, arg1: 0x2::coin::Coin<PEPE>) {
        0x2::coin::burn<PEPE>(arg0, arg1);
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE>(arg0, 6, b"PEPES", b"PEPESUI", b"PEPESUI Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://gateway.pinata.cloud/ipfs/QmSJoTmrSsxPYs3bH6U6oPgLGBrsCceMKtNYySVJ2xDY5M"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE>>(v0, @0x51ef01acee7bcbc4849c9f35ce4a2491ab37824960fbcb4d764d4ab155ee7279);
    }

    public entry fun minto(arg0: &mut 0x2::coin::TreasuryCap<PEPE>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PEPE>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

