module 0xe407b00e592fd9b777fd8917d3ae89859bb7406bb27e64fc19cd7e9dafb8b7a9::suitama {
    struct SUITAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITAMA>(arg0, 2, b"findmeon@suitamasui", b"findmeon@suitamasui", b"findmeon@suitamasui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITAMA>>(v1);
        0x2::coin::mint_and_transfer<SUITAMA>(&mut v2, 100, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITAMA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

