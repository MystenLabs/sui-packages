module 0x5eace1981ee1e465271d0f4e65258d93d613489cf4beae142dd32a955f2695fd::glh {
    struct GLH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLH>(arg0, 6, b"GLH", b"Germanys Last Hope", b"Introducing GLHCOIN, the meme coin inspired by Germanys GLH party and Alice Weidel. GLH represents a movement for those seeking a strong, united Germany, combining political values with digital innovation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042147_db0858981f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLH>>(v1);
    }

    // decompiled from Move bytecode v6
}

