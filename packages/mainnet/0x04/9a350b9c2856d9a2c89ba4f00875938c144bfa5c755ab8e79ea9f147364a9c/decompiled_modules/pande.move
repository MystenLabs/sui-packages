module 0x49a350b9c2856d9a2c89ba4f00875938c144bfa5c755ab8e79ea9f147364a9c::pande {
    struct PANDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANDE>(arg0, 6, b"PANDE", b"Pande", b"Pande had lost his appetite for bamboo and now wants to feed on dips. Join Pande on his venture into the world of meme and the meme coin degen community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pande_Sui_56eb581090.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

