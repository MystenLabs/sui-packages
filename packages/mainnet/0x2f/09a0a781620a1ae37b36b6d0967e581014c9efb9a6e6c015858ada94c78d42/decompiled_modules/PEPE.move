module 0x2f09a0a781620a1ae37b36b6d0967e581014c9efb9a6e6c015858ada94c78d42::PEPE {
    struct PEPE has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEPE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPE>>(0x2::coin::mint<PEPE>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE>(arg0, 9, b"https://twitter.com/PepeSuiIsHere", b"https://twitter.com/PepeSuiIsHere", b"$PEPE. The most memeable memecoin in existence. - https://twitter.com/PepeSuiIsHere", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1654063217965166593/kzmNMuF0_400x400.jpg"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEPE>>(v1, 0x2::tx_context::sender(arg1));
    }

    entry fun renounce_owner(arg0: &mut 0x2::coin::TreasuryCap<PEPE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPE>>(0x2::coin::mint<PEPE>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

