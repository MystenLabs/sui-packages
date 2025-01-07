module 0x23a30002813774e5b49aa232f41fbbb26bf38def93ff3f5eacc17c02687f2ee3::itachi_ {
    struct ITACHI_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITACHI_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ITACHI_>(arg0, 9, b"ITACHI_", b"Itachi", b"It's the representation of the Uchiha.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5a10af6f-8023-44f4-a0bf-afdac5a572a2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITACHI_>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ITACHI_>>(v1);
    }

    // decompiled from Move bytecode v6
}

