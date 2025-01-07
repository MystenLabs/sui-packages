module 0xb6c0ab86483c067bbd9ea00b11340cbb5c6e3cd2fe4e5853f50486641606afdb::gdsg {
    struct GDSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GDSG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GDSG>(arg0, 9, b"GDSG", b"SDGDSA", b"GVSSD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f17bfbb5-1d18-465a-a11b-068cbc9ee73b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDSG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GDSG>>(v1);
    }

    // decompiled from Move bytecode v6
}

