module 0x65af3a95aefa92f01e99cc60db8c6d1608d34ed1a7b43fb15066f0060746ea40::sui_kimak {
    struct SUI_KIMAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_KIMAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_KIMAK>(arg0, 6, b"SUIKIMAK", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_KIMAK>>(v1);
        0x2::coin::mint_and_transfer<SUI_KIMAK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_KIMAK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

