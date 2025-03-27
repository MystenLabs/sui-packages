module 0x74ea96af5f802254daf06f0a859c139a263f49c42599d7abca9b0304cc899c84::floxi {
    struct FLOXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOXI>(arg0, 6, b"FLOXI", b"Floxi the Walrus", b"Floxi, The Walrus That Takes SUI Memecoins Seriously.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000076417_8203456c2b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOXI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOXI>>(v1);
    }

    // decompiled from Move bytecode v6
}

