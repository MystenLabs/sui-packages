module 0xe4be071b05bd1606091781dd2dc454ed2cd101685f358ef6c45d68bb5bbefc38::pewpew {
    struct PEWPEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEWPEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEWPEW>(arg0, 6, b"PEWPEW", b"PEWPEW ON SUI", b"THE ONLY EWPEW ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pewpew_abfd61d60f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEWPEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEWPEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

