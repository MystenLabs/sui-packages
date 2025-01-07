module 0x7744531c21e16a66319427d3aee2c02e9668bc6483cdde50733e98d3c3fe9614::fds {
    struct FDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDS>(arg0, 9, b"FDS", b"J", b"FV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b7e45744-fd34-47d8-be37-87c1b6745574.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

