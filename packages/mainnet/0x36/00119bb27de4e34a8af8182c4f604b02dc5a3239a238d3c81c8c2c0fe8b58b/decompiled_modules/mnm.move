module 0x3600119bb27de4e34a8af8182c4f604b02dc5a3239a238d3c81c8c2c0fe8b58b::mnm {
    struct MNM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNM>(arg0, 9, b"MNM", b"minion", b"bright and happy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e27073e1-eea0-4a69-bd25-10645423cac2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MNM>>(v1);
    }

    // decompiled from Move bytecode v6
}

