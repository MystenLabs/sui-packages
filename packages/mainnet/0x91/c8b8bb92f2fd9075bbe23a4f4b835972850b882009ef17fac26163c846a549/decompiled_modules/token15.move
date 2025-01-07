module 0x91c8b8bb92f2fd9075bbe23a4f4b835972850b882009ef17fac26163c846a549::token15 {
    struct TOKEN15 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOKEN15>, arg1: 0x2::coin::Coin<TOKEN15>) {
        0x2::coin::burn<TOKEN15>(arg0, arg1);
    }

    fun init(arg0: TOKEN15, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN15>(arg0, 9, b"rewardclub.online", b"rewardclub.online", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN15>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN15>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOKEN15>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TOKEN15>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

