module 0xa4b5753b5ddc54d176b8c4cdf9d3d184ec5424abe11a5874909b6871ba62ff1a::musape {
    struct MUSAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSAPE>(arg0, 6, b"MUSAPE", b"Muscular sui ape", b"The well-known ape from Sui called Slape. He is ready to take on the bears, slapping them all in the face.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul4_20241213155613_bffe0b956a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUSAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

