module 0xc9306e8f247ba40130c3a7465fdb07db4d6ee6d59d37fe271e8d485da90d4845::nsc {
    struct NSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSC>(arg0, 9, b"NSC", b"Ninja Shadow Cat", b"only cat ninja", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8ce851698f66ccf058a9bc386d4d7e0ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NSC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

