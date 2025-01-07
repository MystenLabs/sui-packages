module 0x76f0ec5a696a052632602acb5acb5f234af965db35c9fe49051aa02b07138675::ghf {
    struct GHF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHF>(arg0, 9, b"GHF", b"J", b"M", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ff21af20-4408-4c8d-b413-d1d48e7105fc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GHF>>(v1);
    }

    // decompiled from Move bytecode v6
}

