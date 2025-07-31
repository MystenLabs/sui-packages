module 0xc7fa18d46db6d971ad8aae11badb72ac1629adcac3283b2f8f4be593ed8c5096::pig {
    struct PIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIG>(arg0, 6, b"PIG", b"$QUID-PIG", x"496e74726f647563696e672024515549442d504947202824504947292c20746865206d656d65636f696e20626f726e2066726f6d20746865206173686573206f662024494b41e28099732065706963206c61756e636820666c6f7021200a0a24494b4120686f6c6465727320617265206c656674207769746820726573656e746d656e742c207768696c65206f746865727320676f7420736f6d6520706f726b792070726f666974732e0a0a4a6f696e207468652024515549442d50494720686572642c207768657265206576657279207472616e73616374696f6e206973206120736e6f7274206f662064656669616e6365210a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1753940209522.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

