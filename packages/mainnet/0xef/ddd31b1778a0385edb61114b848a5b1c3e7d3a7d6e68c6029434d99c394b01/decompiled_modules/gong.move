module 0xefddd31b1778a0385edb61114b848a5b1c3e7d3a7d6e68c6029434d99c394b01::gong {
    struct GONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GONG>(arg0, 9, b"Gong", b"meme-gxb", b"Test on 2025, show how powerful of SUI network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/52724878bb40bbe0eee51ae272431bfeblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GONG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GONG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

