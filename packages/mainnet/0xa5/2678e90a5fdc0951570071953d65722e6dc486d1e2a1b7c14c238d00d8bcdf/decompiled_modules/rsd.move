module 0xa52678e90a5fdc0951570071953d65722e6dc486d1e2a1b7c14c238d00d8bcdf::rsd {
    struct RSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RSD>(arg0, 9, b"RSD", b"Rusdingawi", b"Rusdi is the greatest king of ngawi ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/60d63305-c360-44e7-8241-e968de18af2a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

