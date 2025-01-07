module 0x512f7ea553294bae5900f4f3c27e0c3f8dd8f48770e0fb07ce2c9b2b7257f6b9::eymeria_coin {
    struct EYMERIA_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EYMERIA_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EYMERIA_COIN>(arg0, 9, b"Eymeria-cyper", b"One Piece!", b"Eymeria game coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://avatars.githubusercontent.com/u/90686202"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EYMERIA_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EYMERIA_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_in_my_module(arg0: &mut 0x2::coin::TreasuryCap<EYMERIA_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<EYMERIA_COIN>>(0x2::coin::mint<EYMERIA_COIN>(arg0, arg1 * 1000000000, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

