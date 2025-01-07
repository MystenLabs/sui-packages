module 0x9420fc7d55049f371168c6e8930ae78941637dc3cf1dc66ef86520017f23f731::bv {
    struct BV has drop {
        dummy_field: bool,
    }

    fun init(arg0: BV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BV>(arg0, 9, b"BV", b"Cc", b"Tyy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6c8851fd-d44b-42a0-96f4-6bd497762c27.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BV>>(v1);
    }

    // decompiled from Move bytecode v6
}

