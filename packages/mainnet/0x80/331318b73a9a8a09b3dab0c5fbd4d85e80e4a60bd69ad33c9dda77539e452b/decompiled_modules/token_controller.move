module 0x80331318b73a9a8a09b3dab0c5fbd4d85e80e4a60bd69ad33c9dda77539e452b::token_controller {
    struct Token has drop, store {
        dummy_field: bool,
    }

    public entry fun burn_tokens(arg0: &mut 0x2::coin::TreasuryCap<Token>, arg1: 0x2::coin::Coin<Token>) {
        0x2::coin::burn<Token>(arg0, arg1);
    }

    public entry fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Token{dummy_field: false};
        let (v1, v2) = 0x2::coin::create_currency<Token>(v0, 8, b"FHF", b"Family Heritage Foundation USD", b"FHF USD", 0x1::option::none<0x2::url::Url>(), arg0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<Token>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Token>>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint_tokens(arg0: &mut 0x2::coin::TreasuryCap<Token>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<Token>>(0x2::coin::mint<Token>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

