module 0xcccbc26840ac46c8451f71a7bc48435f3bffca597ad87644420bda445223d17b::lon {
    struct LON has drop {
        dummy_field: bool,
    }

    fun init(arg0: LON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LON>(arg0, 9, b"LON", b"lon", b"good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e14e01bf-d5b0-4fdf-8513-9bdfad1238bf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LON>>(v1);
    }

    // decompiled from Move bytecode v6
}

