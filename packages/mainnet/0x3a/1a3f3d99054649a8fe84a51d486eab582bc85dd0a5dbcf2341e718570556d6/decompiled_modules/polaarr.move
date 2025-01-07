module 0x3a1a3f3d99054649a8fe84a51d486eab582bc85dd0a5dbcf2341e718570556d6::polaarr {
    struct POLAARR has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLAARR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLAARR>(arg0, 6, b"Polaarr", x"506f6c61722053756920f09f92a7", b"Experience the future of crypto with $POLAR Sui, the premium memecoin for the discerning investor. Coming soon on turbos.finance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731235169451.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POLAARR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLAARR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

