module 0xee3a0205b94f188c7698121775a58d8e31ada698e2e79cfc717f3b5745ae133b::grm {
    struct GRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRM>(arg0, 9, b"GRM", b"grandmothe", b"Along with delicious food", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/da575402-0055-424d-beb0-f69bf5e979f8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

