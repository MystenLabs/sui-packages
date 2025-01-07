module 0x8b591fc328000c9507fb6bd70e1a6f0fd2a7605e7c1fb9c02b17680ca924c79d::start {
    struct START has drop {
        dummy_field: bool,
    }

    fun init(arg0: START, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<START>(arg0, 6, b"START", b"start", b"start token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/vWHUeox4Gi6FyuoogTlQ0Z9Z1w-fF1kkPQ6Wz0i2TL0")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<START>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<START>>(v2, @0x703cd1c1f68d239745a177b522a2f8651e8f8cd86e91ad9322cbec99b204ce38);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<START>>(v1);
    }

    // decompiled from Move bytecode v6
}

