module 0xc6c626e5a78d6070be8193f67a0167e910a3432ad71db05997c52fe60ecb49f4::ngh {
    struct NGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGH>(arg0, 9, b"NGH", b"DFHGD", b"DFGBS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5333084a-0388-43bf-8126-381b42ae8899.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

