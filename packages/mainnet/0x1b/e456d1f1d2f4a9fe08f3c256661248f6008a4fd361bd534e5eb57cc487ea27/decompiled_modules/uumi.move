module 0x1be456d1f1d2f4a9fe08f3c256661248f6008a4fd361bd534e5eb57cc487ea27::uumi {
    struct UUMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UUMI>(arg0, 9, b"UUMI", b"Uumi", b"Meet Uumi, the cutest dog of sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<UUMI>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UUMI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UUMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

