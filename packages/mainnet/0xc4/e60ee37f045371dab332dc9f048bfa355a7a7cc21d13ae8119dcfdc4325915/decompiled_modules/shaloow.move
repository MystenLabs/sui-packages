module 0xc4e60ee37f045371dab332dc9f048bfa355a7a7cc21d13ae8119dcfdc4325915::shaloow {
    struct SHALOOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHALOOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHALOOW>(arg0, 6, b"SHALOOW", b"Sui-haloow", b"Sui-Haloow is a Halloween-themed token on the Sui blockchain, bringing a spooky twist to the crypto world. Inspired by the spirit of Halloween, Sui-Haloow offers thrilling rewards and engaging community events. Embrace the eerie vibes, collect exclusive treats, and join the haunting journey of Sui-Haloow as it lights up the crypto space with excitement and festive fun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/10a42f73_25ff_468a_92af_a141543fc34f_db07839672.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHALOOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHALOOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

