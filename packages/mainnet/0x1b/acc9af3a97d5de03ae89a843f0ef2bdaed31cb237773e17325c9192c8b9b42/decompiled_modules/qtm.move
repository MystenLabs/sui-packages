module 0x1bacc9af3a97d5de03ae89a843f0ef2bdaed31cb237773e17325c9192c8b9b42::qtm {
    struct QTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: QTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QTM>(arg0, 9, b"QTM", b"qutem", b"qutem airdrops", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://yapx.ru/album/W48WT")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<QTM>(&mut v2, 70000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QTM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QTM>>(v1);
    }

    // decompiled from Move bytecode v6
}

