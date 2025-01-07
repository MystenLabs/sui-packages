module 0xb5357c64096569ee04c5e4b090fbb5a71ebde34e5884207855934f5d9c21cd6::croxo {
    struct CROXO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROXO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROXO>(arg0, 6, b"CROXO", b"Croxo Sui", b"The meme supercycle is definitely coming, but it's a marathon, not a sprint. If you get scared easily, you'll never see the finish line", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000056196_ca30f717fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROXO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROXO>>(v1);
    }

    // decompiled from Move bytecode v6
}

