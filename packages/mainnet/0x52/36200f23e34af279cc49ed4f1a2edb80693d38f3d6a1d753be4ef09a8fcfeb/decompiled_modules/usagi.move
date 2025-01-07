module 0x5236200f23e34af279cc49ed4f1a2edb80693d38f3d6a1d753be4ef09a8fcfeb::usagi {
    struct USAGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: USAGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USAGI>(arg0, 6, b"Usagi", b"Chiikawa", b"Usagi is a Japanese writer with a unique intention, a Chinese literary writer, a writer, and a Japanese writer on January 22, but he can't speak, but his greatest feature is music!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8901_28b33d46c2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USAGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USAGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

