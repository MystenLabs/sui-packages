module 0x2c478945a974cf55fd06ec9a1b1b7d961bd6c015de5bdd64d3919dae2d6a5db6::pha {
    struct PHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHA>(arg0, 9, b"PHA", b"PHAKE PHAK", b"PHAKE ACAS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dc206a64-05d9-48ca-bd13-0d0d01da0ac3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

