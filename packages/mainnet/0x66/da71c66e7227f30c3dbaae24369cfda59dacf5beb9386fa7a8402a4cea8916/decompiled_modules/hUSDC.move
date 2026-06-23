module 0x66da71c66e7227f30c3dbaae24369cfda59dacf5beb9386fa7a8402a4cea8916::hUSDC {
    struct HUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUSDC>(arg0, 6, b"hUSDC", b"hUSDC Coin", b"hUSDC Coin - yield-bearing representation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"/images/htokens/husdc.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUSDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUSDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

