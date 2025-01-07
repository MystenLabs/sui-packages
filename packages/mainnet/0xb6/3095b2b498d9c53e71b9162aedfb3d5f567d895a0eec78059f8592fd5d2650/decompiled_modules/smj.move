module 0xb63095b2b498d9c53e71b9162aedfb3d5f567d895a0eec78059f8592fd5d2650::smj {
    struct SMJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMJ>(arg0, 6, b"SMJ", b"SUI EMOJI", b"LESGOO MEME TOKEN IS RILLLL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/smr_d113d518f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

