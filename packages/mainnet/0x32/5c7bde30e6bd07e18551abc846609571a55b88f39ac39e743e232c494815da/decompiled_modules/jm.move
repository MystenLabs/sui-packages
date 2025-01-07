module 0x325c7bde30e6bd07e18551abc846609571a55b88f39ac39e743e232c494815da::jm {
    struct JM has drop {
        dummy_field: bool,
    }

    fun init(arg0: JM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JM>(arg0, 9, b"JM", b"janggom", b"11", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cff007c6-cbe7-400d-81b1-8528d7a629de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JM>>(v1);
    }

    // decompiled from Move bytecode v6
}

