module 0xd4a196207a857e77665644195f0f7bd0e79f801261b4662d7c17e19f194dd84b::mc {
    struct MC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MC>(arg0, 6, b"MC", b"Meme Cooking", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MC>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MC>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MC>>(v2);
    }

    // decompiled from Move bytecode v6
}

