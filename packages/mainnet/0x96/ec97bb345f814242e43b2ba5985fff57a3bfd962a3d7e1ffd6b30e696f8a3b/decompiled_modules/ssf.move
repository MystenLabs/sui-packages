module 0x96ec97bb345f814242e43b2ba5985fff57a3bfd962a3d7e1ffd6b30e696f8a3b::ssf {
    struct SSF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSF>(arg0, 6, b"SSF", b"SuiStarFish", b"A starfish wandering in the sea, afraid of being eaten by big fish.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c8f5349b_b18c_48d4_a4c6_fe71f6de8194_1_5a5c210228.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSF>>(v1);
    }

    // decompiled from Move bytecode v6
}

