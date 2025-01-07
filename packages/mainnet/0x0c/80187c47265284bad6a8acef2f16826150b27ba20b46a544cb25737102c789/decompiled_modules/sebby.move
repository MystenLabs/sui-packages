module 0xc80187c47265284bad6a8acef2f16826150b27ba20b46a544cb25737102c789::sebby {
    struct SEBBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEBBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEBBY>(arg0, 6, b"SEBBY", b"SebbyTheSausage", b"Sebby needs a hug", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9e6k3u_a82689377f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEBBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEBBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

