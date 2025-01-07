module 0x3969654f9eeac8ff4ea06a75cd3a24ded260fc44d106dfb701bee2be0487565a::shghghg {
    struct SHGHGHG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHGHGHG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHGHGHG>(arg0, 9, b"SHGHGHG", b"fgdfgdf", b"ghghgh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a154b117-99cf-495f-ad7c-7afb84d85947.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHGHGHG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHGHGHG>>(v1);
    }

    // decompiled from Move bytecode v6
}

