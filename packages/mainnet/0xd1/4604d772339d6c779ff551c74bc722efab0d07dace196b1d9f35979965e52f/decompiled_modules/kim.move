module 0xd14604d772339d6c779ff551c74bc722efab0d07dace196b1d9f35979965e52f::kim {
    struct KIM has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KIM>, arg1: 0x2::coin::Coin<KIM>) {
        0x2::coin::burn<KIM>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KIM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KIM>>(0x2::coin::mint<KIM>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: KIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIM>(arg0, 9, b"KIM", b"KIM", b"Hello world!", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

