module 0xb29814db92f10e474a54ba81659fb9e1a6b4722bdc0eeeffd6429f7c9afb62bd::swomen {
    struct SWOMEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOMEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOMEN>(arg0, 6, b"Swomen", b"Suiwomen", b"Suiwomen is a meme token on the Sui, combining the fun of superhero vibes with the power of the Sui blockchain. Powered by the community, it's a lighthearted tribute to crypto culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kandinsky_download_1728326901948_64d92a5946.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWOMEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWOMEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

