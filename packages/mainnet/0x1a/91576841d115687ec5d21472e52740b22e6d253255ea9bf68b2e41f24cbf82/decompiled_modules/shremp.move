module 0x1a91576841d115687ec5d21472e52740b22e6d253255ea9bf68b2e41f24cbf82::shremp {
    struct SHREMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHREMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHREMP>(arg0, 6, b"SHREMP", b"Shremp", b"I'm set to eclipse Pepe! Brace yourselves for intergalactic laughs with Shrempin memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/shrempdisco_80a76ba4af.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHREMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHREMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

