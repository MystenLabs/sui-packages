module 0x1728baa875e678d55c7f7e78749419916056c5bf279187d2b49dae10f92696ae::dgtu {
    struct DGTU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGTU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGTU>(arg0, 6, b"DGTU", b"DogTongue On Sui", b"Let's lick and party together, Dogtongue meme coin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000560_34a6f36e76.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGTU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DGTU>>(v1);
    }

    // decompiled from Move bytecode v6
}

