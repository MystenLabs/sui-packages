module 0x9dd702b950847d1bf2453a1ac70a4eb5fe7efdfb6298e8965bd6c3060f330289::md {
    struct MD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MD>(arg0, 9, b"MD", b"MEMEDANNEY", b"Memedanney is a community-driven meme token that's all about spreading laughter and joy. With its humble beginnings as an internet meme, Memedanney has evolved into a vibrant ecosystem that celebrates creativity, humor, and decentralization.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8bd715e8-8b1e-42e5-b485-4a5078be3da8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MD>>(v1);
    }

    // decompiled from Move bytecode v6
}

