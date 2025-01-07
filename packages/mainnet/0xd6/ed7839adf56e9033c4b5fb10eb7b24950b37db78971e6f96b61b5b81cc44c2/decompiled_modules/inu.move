module 0xd6ed7839adf56e9033c4b5fb10eb7b24950b37db78971e6f96b61b5b81cc44c2::inu {
    struct INU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<INU>, arg1: 0x2::coin::Coin<INU>) {
        0x2::coin::burn<INU>(arg0, arg1);
    }

    fun init(arg0: INU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INU>(arg0, 6, b"INU", b"Inu", b"Woof", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<INU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<INU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

