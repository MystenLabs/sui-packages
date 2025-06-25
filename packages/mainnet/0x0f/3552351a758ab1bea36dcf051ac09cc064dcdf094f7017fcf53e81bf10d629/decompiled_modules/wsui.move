module 0xf3552351a758ab1bea36dcf051ac09cc064dcdf094f7017fcf53e81bf10d629::wsui {
    struct WSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSUI>(arg0, 9, b"wSUI", b"Wata SUI", b"Wata SUI is a liquidity token for Wata.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://wata.wal.app/images/wsui.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

