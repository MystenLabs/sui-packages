module 0x624cc25c012bb6c8c9d18282449b043fe22a7d3e79852dbaf9e637702bfb9aaa::sagi {
    struct SAGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAGI>(arg0, 6, b"SAGI", b"Sui AGI", b"This is first AGI(Artificial General Intelligence) Meme token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/1000032234_4bccab9a21.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

