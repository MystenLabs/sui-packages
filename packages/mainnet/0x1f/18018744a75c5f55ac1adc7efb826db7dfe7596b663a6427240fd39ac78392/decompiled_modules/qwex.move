module 0x1f18018744a75c5f55ac1adc7efb826db7dfe7596b663a6427240fd39ac78392::qwex {
    struct QWEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: QWEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QWEX>(arg0, 9, b"QWEX", b"Qwex", b"The new mascot for the Sui ecosystem is the royal penguin Qwex", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dribbble.com/userupload/16064155/file/original-a52370e0a2d9a06b79170de617c56bd7.jpg?resize=752x564")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<QWEX>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QWEX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QWEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

