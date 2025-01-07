module 0xcada30f4bb81a197a2d26393278cf66dfff6ee620a4239c790e52f15bb31b967::jellyal {
    struct JELLYAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: JELLYAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JELLYAL>(arg0, 6, b"JELLYAL", b"JellAL", b"FAKE JELLY DONT BUY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731011523824.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JELLYAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JELLYAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

