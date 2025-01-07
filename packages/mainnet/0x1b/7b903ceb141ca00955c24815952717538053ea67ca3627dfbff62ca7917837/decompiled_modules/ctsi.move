module 0x1b7b903ceb141ca00955c24815952717538053ea67ca3627dfbff62ca7917837::ctsi {
    struct CTSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTSI>(arg0, 6, b"CTSI", b"CATOSI", b"CATOSI is Cat from Japan  Stealth Fish for FAT, cute Cat FROM CATOSI, Let me eat the fish from the sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000210814_e9b0dd5915.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

