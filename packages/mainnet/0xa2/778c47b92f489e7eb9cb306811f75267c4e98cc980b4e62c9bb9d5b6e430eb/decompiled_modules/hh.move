module 0xa2778c47b92f489e7eb9cb306811f75267c4e98cc980b4e62c9bb9d5b6e430eb::hh {
    struct HH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HH>(arg0, 9, b"HH", b"Gh", b"Hhhj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/75f174f6-9092-4e44-9549-c56113c455fe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HH>>(v1);
    }

    // decompiled from Move bytecode v6
}

