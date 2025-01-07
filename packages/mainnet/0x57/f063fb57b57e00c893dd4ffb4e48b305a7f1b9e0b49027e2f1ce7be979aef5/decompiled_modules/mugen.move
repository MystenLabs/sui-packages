module 0x57f063fb57b57e00c893dd4ffb4e48b305a7f1b9e0b49027e2f1ce7be979aef5::mugen {
    struct MUGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUGEN>(arg0, 9, b"MUGEN", b"MUU GEN", b"M UU GEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2439aa38-893f-480b-b4e1-91766d195716.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUGEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUGEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

