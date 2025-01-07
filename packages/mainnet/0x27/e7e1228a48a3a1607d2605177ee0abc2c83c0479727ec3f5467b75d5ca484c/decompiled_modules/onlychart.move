module 0x27e7e1228a48a3a1607d2605177ee0abc2c83c0479727ec3f5467b75d5ca484c::onlychart {
    struct ONLYCHART has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONLYCHART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONLYCHART>(arg0, 9, b"ONLYCHART", b"Only chart", b"It represent crypto arts group", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e43d9e1a-2fb9-4bdd-afd0-647f81201ae5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONLYCHART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONLYCHART>>(v1);
    }

    // decompiled from Move bytecode v6
}

