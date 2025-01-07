module 0xd98970582ee4c1e0a26e0c9f768a65df559739dc32c6f9bb488617d8f2da386a::countduck {
    struct COUNTDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COUNTDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COUNTDUCK>(arg0, 6, b"Countduck", b"Counting duck", b"A project named after meme made by suins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731473176253.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COUNTDUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COUNTDUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

