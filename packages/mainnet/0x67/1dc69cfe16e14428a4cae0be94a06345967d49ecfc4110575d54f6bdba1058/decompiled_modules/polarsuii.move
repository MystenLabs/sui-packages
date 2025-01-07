module 0x671dc69cfe16e14428a4cae0be94a06345967d49ecfc4110575d54f6bdba1058::polarsuii {
    struct POLARSUII has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLARSUII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLARSUII>(arg0, 6, b"Polarsuii", x"506f6c61722053756920f09f92a7", b"Experience the future of crypto with $POLAR Sui, the premium memecoin for the discerning investor. Coming soon on turbos.finance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731257720113.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POLARSUII>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLARSUII>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

