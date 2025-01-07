module 0xaee22720a1a4f7666b4ce2b1823abf1fe7951f749d60b495a9673ec2017b9939::jumbodog {
    struct JUMBODOG has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<JUMBODOG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<JUMBODOG>>(0x2::coin::mint<JUMBODOG>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: JUMBODOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUMBODOG>(arg0, 6, b"Sui Jumbo Dog", b"sJumboDog", b"Sui Jumbo Dog Meme Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUMBODOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUMBODOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

