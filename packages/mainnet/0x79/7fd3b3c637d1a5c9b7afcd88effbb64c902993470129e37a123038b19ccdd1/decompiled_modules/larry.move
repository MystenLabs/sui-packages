module 0x797fd3b3c637d1a5c9b7afcd88effbb64c902993470129e37a123038b19ccdd1::larry {
    struct LARRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LARRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LARRY>(arg0, 6, b"LARRY", b"Larry Coin Sui", b"$LARRY  Larry The Cat  | Kabosumamas beloved cat, Born on SUI  the chain of legendary cats!  Diamond hands only  | Step-by-step community growth  Join early. Stay based. Build history. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000063010_02c5789f6a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LARRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LARRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

