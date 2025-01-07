module 0x5527254c5ebb2dd2182ac84c477e792ca008468f582b992d385af1ce3b1d10fe::concac {
    struct CONCAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONCAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONCAC>(arg0, 9, b"CONCAC", b"Con cac", x"4e68c6b0206363", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/46c3dd66-ec02-4427-9afb-5e0f6dc69f7e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONCAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CONCAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

