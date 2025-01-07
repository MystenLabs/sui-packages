module 0x835c1c2c6074598451b710be0dda88319a10b6917e6668b3388d321f2f0a01c0::loppy {
    struct LOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOPPY>(arg0, 6, b"Loppy", b"LoopySUI", b"We can do it because we are cute! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lopy_ac3d333989.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

