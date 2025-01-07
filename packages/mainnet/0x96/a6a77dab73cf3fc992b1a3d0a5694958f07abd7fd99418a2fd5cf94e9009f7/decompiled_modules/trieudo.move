module 0x96a6a77dab73cf3fc992b1a3d0a5694958f07abd7fd99418a2fd5cf94e9009f7::trieudo {
    struct TRIEUDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIEUDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIEUDO>(arg0, 9, b"TRIEUDO", b"50tynhe", b"2mnh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/183d9593-0e09-4f7b-84ac-74b6ae522fa1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIEUDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRIEUDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

