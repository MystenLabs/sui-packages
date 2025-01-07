module 0xbd2bbef578d19fb80a6c5dcd591c4047ac63fe84905748aa7b701b18a5124889::pooka {
    struct POOKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOKA>(arg0, 6, b"Pooka", b"Fairy", b" Pooka is so overpowered that if we help it grow as a community, the other memes will have to work to keep up...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/adadad_3ae4f39c6a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

