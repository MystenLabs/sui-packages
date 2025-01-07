module 0x3f6bf66586052100235a4e00511495d3d3148b3668772339d3b6a569f7661202::avasui {
    struct AVASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVASUI>(arg0, 6, b"AvaSui", b"AVA Tiger", b"Cute AVA TIGER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732209984917.chrome")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AVASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVASUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

