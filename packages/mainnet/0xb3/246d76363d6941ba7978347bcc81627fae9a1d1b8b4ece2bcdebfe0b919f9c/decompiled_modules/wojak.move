module 0xb3246d76363d6941ba7978347bcc81627fae9a1d1b8b4ece2bcdebfe0b919f9c::wojak {
    struct WOJAK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WOJAK>, arg1: 0x2::coin::Coin<WOJAK>) {
        0x2::coin::burn<WOJAK>(arg0, arg1);
    }

    fun init(arg0: WOJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOJAK>(arg0, 2, b"WOJAK", b"WOJAK", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOJAK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOJAK>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WOJAK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WOJAK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

