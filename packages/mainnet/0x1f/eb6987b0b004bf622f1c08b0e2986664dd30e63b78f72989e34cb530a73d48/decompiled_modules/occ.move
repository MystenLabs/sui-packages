module 0x1feb6987b0b004bf622f1c08b0e2986664dd30e63b78f72989e34cb530a73d48::occ {
    struct OCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCC>(arg0, 9, b"OCC", b"Ococ", b"Ococ is a lovely boy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/55b9bcc0-f13b-456f-8174-446a0387a65d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCC>>(v1);
    }

    // decompiled from Move bytecode v6
}

