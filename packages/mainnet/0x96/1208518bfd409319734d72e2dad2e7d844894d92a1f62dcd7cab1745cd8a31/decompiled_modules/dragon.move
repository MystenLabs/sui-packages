module 0x961208518bfd409319734d72e2dad2e7d844894d92a1f62dcd7cab1745cd8a31::dragon {
    struct DRAGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGON>(arg0, 6, b"DRAGON", b"SuiLitchDragon", b"The first dragon meme coin on the Sui blockchain! LFG!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000069197_d3dd380846.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAGON>>(v1);
    }

    // decompiled from Move bytecode v6
}

