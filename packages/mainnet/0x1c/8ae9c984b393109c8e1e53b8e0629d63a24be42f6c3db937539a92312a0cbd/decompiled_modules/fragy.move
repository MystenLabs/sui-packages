module 0x1c8ae9c984b393109c8e1e53b8e0629d63a24be42f6c3db937539a92312a0cbd::fragy {
    struct FRAGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRAGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRAGY>(arg0, 6, b"FRAGY", b"Yellow Fragy", b"Yellow Fragy - is the resilient baby frog of Base Blockchain with an engaging community and the most innovative AI-driven apps. Join us as we create a fresh and dynamic experience in the world of meme coins!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000069276_d9b6a07355.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRAGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRAGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

