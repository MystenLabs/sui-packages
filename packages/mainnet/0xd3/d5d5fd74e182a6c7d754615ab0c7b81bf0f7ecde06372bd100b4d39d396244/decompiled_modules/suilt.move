module 0xd3d5d5fd74e182a6c7d754615ab0c7b81bf0f7ecde06372bd100b4d39d396244::suilt {
    struct SUILT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILT>(arg0, 6, b"SUILT", b"SUILTAN", b"Welcome to the digital kingdom of SUILTAN, where blockchain power meets sultan-style wealth! Built on the SUI network, $SUILT is the meme coin for those who dream of digital treasures and rul", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730460709228.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUILT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

