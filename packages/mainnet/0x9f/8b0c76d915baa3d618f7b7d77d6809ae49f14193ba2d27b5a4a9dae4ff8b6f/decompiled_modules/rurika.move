module 0x9f8b0c76d915baa3d618f7b7d77d6809ae49f14193ba2d27b5a4a9dae4ff8b6f::rurika {
    struct RURIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RURIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RURIKA>(arg0, 6, b"Rurika", b"RURIKA AI", b"Hi! Im Rurika, a girl with blue hair who loves cute things and big dreams. Im always with my little squirrel, Chibi, who keeps me company with his playful energy and tiny snacks. Together, we love enjoying the sky, sweet moments, and all things fluffy! Life should be soft and joyful, just like us.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250111_222438_361_88dac25a6f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RURIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RURIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

