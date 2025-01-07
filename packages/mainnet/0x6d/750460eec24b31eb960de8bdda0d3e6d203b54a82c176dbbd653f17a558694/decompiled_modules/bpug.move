module 0x6d750460eec24b31eb960de8bdda0d3e6d203b54a82c176dbbd653f17a558694::bpug {
    struct BPUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPUG>(arg0, 6, b"BPUG", b"Baby Pug", b"With tiny paws and big dreams, $BPUG will aim to spread joy, memes, and silliness across the ecosystem. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sem_t_A_tulo_1_8690a9c157.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

