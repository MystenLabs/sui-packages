module 0x1682b9589b315d02db74fd239fc37b05230be2719b7c4a9068a905c798f13f67::MONOTARO {
    struct MONOTARO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MONOTARO>, arg1: 0x2::coin::Coin<MONOTARO>) {
        0x2::coin::burn<MONOTARO>(arg0, arg1);
    }

    fun init(arg0: MONOTARO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONOTARO>(arg0, 9, b"MONOTARO", b"MONOTARO", b"https://imgbb.com/][img]https://i.ibb.co/923pjf7/MONOTARO.png", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONOTARO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONOTARO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MONOTARO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MONOTARO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

