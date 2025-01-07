module 0xa860df89015a838071a13c4cae0b6d750e1e37ec3fa4a058e3038b0094bbf0df::mdr {
    struct MDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDR>(arg0, 9, b"MDR", b"MADURA", b"tradisi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cd8e795b-dbec-4164-b59b-bbd419570ccc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MDR>>(v1);
    }

    // decompiled from Move bytecode v6
}

