module 0x86367ef42ff8cd173e7ae814a6ff99d6186cb666e38e37cc68fc50d1cd82674f::splo {
    struct SPLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLO>(arg0, 6, b"SPLO", b"Sorry which way", b"Sorry, which way ?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SPOLL_bcecbf2865.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

