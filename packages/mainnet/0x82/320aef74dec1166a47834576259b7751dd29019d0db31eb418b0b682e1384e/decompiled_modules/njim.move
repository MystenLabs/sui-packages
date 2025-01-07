module 0x82320aef74dec1166a47834576259b7751dd29019d0db31eb418b0b682e1384e::njim {
    struct NJIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NJIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NJIM>(arg0, 6, b"NJIM", b"Naked Jim", b"An original meme coin bearing it all on Solana (and beyond)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/673567_1_029329ae67.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NJIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NJIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

