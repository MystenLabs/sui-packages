module 0x7277518e848d9f87a5410149ffbe766ca15ca96723751a1168a0aedc901ba2c1::jesse {
    struct JESSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JESSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JESSE>(arg0, 6, b"JESSE", b"sagasgasgas", b"sagasgasga", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731011092287.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JESSE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JESSE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

