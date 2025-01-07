module 0x42726193d859cf6d59fc5389fb1eec92fc824c68c157daae4365c462d482bd69::bozo {
    struct BOZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOZO>(arg0, 6, b"BOZO", b"Bozo Clown", b"Sui's Most Wanted Clown https://b0z0show.wtf/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_Artwork_7_00828400eb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

