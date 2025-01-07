module 0xd4e5332b33e010e2f6f5b717f7609c381edad989dac126a824d941f0dfd1e12a::dsg {
    struct DSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSG>(arg0, 9, b"DSG", b"FSG", b"GDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/21fb96ca-6810-48fa-bbc5-6dcd8227d20f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSG>>(v1);
    }

    // decompiled from Move bytecode v6
}

