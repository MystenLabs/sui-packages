module 0xa1b076e7266e4399c19178606ecdddabd9b1034db4fab4a3a679fbc94487e04d::SUINHUCHO {
    struct SUINHUCHO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUINHUCHO>, arg1: 0x2::coin::Coin<SUINHUCHO>) {
        0x2::coin::burn<SUINHUCHO>(arg0, arg1);
    }

    fun init(arg0: SUINHUCHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINHUCHO>(arg0, 9, b"SUINHUCHO", b"Suinhucho", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINHUCHO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINHUCHO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUINHUCHO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUINHUCHO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

