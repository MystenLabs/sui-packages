module 0x451daaa0c2a330784284369b011e40b9c3a3ad6ad6f747db1073fc4de47ef3ec::mif {
    struct MIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIF>(arg0, 9, b"MIF", b"milf", b"very urgent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7ed729d1-695e-4560-96a7-1220ff525a09.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

