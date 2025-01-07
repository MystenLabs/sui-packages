module 0xab9de4cb5fe7764087146ee3540eb126c6b7ed03fdaff69d3592cd79e0c3ed20::mei {
    struct MEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEI>(arg0, 9, b"MEI", b"Meimei", b"Sister coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a4f8230f-36c5-4418-96fc-bea6a696896f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

