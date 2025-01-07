module 0xde19ec84c4f02c5e0c835bf34d758809a3ffde0952d6368792c2abd9029c4e4b::rick {
    struct RICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICK>(arg0, 6, b"RICK", b"Rick On Sui", x"4920444f4ee280995420474956452041204655555555434343434b4b4b212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735789268085.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

