module 0xbc0b272ccdfa661d0e35533fd106efc437d29bda1e7e88880d20fd224a640f09::dm {
    struct DM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DM>(arg0, 6, b"DM", b"Degen Mascot", b"DM not direct message, DM is Degen Mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732023928422.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

