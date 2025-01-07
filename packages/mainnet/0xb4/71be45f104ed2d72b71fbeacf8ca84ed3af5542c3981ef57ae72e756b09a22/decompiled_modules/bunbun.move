module 0xb471be45f104ed2d72b71fbeacf8ca84ed3af5542c3981ef57ae72e756b09a22::bunbun {
    struct BUNBUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNBUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNBUN>(arg0, 6, b"BUNBUN", b"Sui Bunbun", b"Meet BUNBUN, a memecoin with the best ticker you'll ever see on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052842_34dededf03.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNBUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUNBUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

