module 0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_token {
    struct FISHER_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHER_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHER_TOKEN>(arg0, 9, b"FISH", b"FISH Token", b"The official token of Sui Fisher game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suifisher.games/token.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FISHER_TOKEN>(&mut v2, 100000000000000000, 0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_config::get_fisher_receiver(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FISHER_TOKEN>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FISHER_TOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

