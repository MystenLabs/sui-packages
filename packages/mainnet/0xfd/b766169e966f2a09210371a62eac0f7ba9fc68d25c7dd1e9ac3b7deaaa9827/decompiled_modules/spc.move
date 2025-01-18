module 0xfdb766169e966f2a09210371a62eac0f7ba9fc68d25c7dd1e9ac3b7deaaa9827::spc {
    struct SPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPC>(arg0, 6, b"SPC", b"SUPER PEPE", x"5355504552205045504520546865206e657874207374657020696e2074686520776f726c64206f662063727970746f63757272656e6369657320f09f8c8df09f928ef09f90b8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737212770919.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

