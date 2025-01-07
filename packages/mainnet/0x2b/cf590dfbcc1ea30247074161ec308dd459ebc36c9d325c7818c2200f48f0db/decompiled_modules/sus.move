module 0x2bcf590dfbcc1ea30247074161ec308dd459ebc36c9d325c7818c2200f48f0db::sus {
    struct SUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUS>(arg0, 9, b"SUS", b"Suss", x"4920616d2073757320f09fa494", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/49617324-3991-43f6-ae06-3b643b198d5c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

