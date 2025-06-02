module 0x5c14dc1cf5b24f9200920889e63f35a904fabf5042f6c7d5bc85f70892444e0a::isr {
    struct ISR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISR>(arg0, 9, b"ISR", b"ISRAEL COIN", b"Send Israel Coin to the MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ISR>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ISR>>(v1);
    }

    // decompiled from Move bytecode v6
}

