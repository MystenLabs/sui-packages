module 0x4ff49ee5660c0def9effdedaac06b0f624324344dd916e120254eef0ff620d4e::rich {
    struct RICH has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICH>(arg0, 9, b"RICH", b"Get rich", b"I swear we will all get rich from this coin i have a plan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2eccfc2a-f61a-4752-b27d-5670f91be8b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICH>>(v1);
    }

    // decompiled from Move bytecode v6
}

