module 0xa9b12b9293a6367f1e9c7366237dfee005a639281a23d17c5215ffec0d6d1fa0::smx6900 {
    struct SMX6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMX6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMX6900>(arg0, 6, b"SMX6900", b"SUI MEME INDEX 6900", b"SUI MEME INDEX ---- 6900 LFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_1_b8b397f5bb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMX6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMX6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

