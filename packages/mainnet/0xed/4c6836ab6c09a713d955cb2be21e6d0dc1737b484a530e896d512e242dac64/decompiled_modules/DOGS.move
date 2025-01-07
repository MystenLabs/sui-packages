module 0xed4c6836ab6c09a713d955cb2be21e6d0dc1737b484a530e896d512e242dac64::DOGS {
    struct DOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGS>(arg0, 9, b"DOGS", b"DOGS", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGS>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOGS>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<DOGS>>(0x2::coin::mint<DOGS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

