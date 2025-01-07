module 0xb310b520fc7eec9644df8b957c921d0974457ca30657101ab6c4997c83c25d1b::penes {
    struct PENES has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENES>(arg0, 6, b"PENES", b"penes", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"penes")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PENES>(&mut v2, 6484848000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENES>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENES>>(v1);
    }

    // decompiled from Move bytecode v6
}

