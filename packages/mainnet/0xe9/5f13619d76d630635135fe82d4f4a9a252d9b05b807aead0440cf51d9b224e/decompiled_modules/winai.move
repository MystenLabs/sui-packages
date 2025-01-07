module 0xe95f13619d76d630635135fe82d4f4a9a252d9b05b807aead0440cf51d9b224e::winai {
    struct WINAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINAI>(arg0, 6, b"WINAI", b"WIN AI", b"MEME AI WIN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WINAI_dec4dac199.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WINAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

