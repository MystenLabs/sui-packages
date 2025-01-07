module 0x571c0562e90c6bcf17e33b54cbe809db49c6b9f13ddecbf9446cb104df708ed0::PUPI {
    struct PUPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPI>(arg0, 9, b"PUPI", b"Pupi Trump", b"Pupi Trump Boost", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUPI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUPI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

