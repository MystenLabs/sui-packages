module 0x514635cae10ef85d792e515448cffc5a4f0a6ce88e154a2982adf5c7b4676a6c::fuck {
    struct FUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCK>(arg0, 6, b"FUCK", b"FUCK SNIPER", b"I hate Sniper", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/top_1_202f9fdba3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

