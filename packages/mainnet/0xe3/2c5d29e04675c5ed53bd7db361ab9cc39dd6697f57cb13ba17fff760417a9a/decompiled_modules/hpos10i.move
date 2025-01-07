module 0xe32c5d29e04675c5ed53bd7db361ab9cc39dd6697f57cb13ba17fff760417a9a::hpos10i {
    struct HPOS10I has drop {
        dummy_field: bool,
    }

    fun init(arg0: HPOS10I, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HPOS10I>(arg0, 6, b"HPOS10I", b"HPOS10I on SUI", b"Ticker $BITCOIN, but on SUI  Parodical satirical multifaceted meme project ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n8uk_vd_S_400x400_0d58dab35b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HPOS10I>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HPOS10I>>(v1);
    }

    // decompiled from Move bytecode v6
}

