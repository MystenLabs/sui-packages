module 0xb54827bbb4606a1722d59341aefa4d73748b6dc372f20b543a50bdac239c2c9c::bofo {
    struct BOFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOFO>(arg0, 6, b"BOFO", b"Buy One Get One Free", b"Give a BOFO, get a BOFO FREE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1760137230584.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOFO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOFO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

