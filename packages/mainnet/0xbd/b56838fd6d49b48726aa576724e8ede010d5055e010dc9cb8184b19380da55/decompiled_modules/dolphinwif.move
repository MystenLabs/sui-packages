module 0xbdb56838fd6d49b48726aa576724e8ede010d5055e010dc9cb8184b19380da55::dolphinwif {
    struct DOLPHINWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPHINWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPHINWIF>(arg0, 6, b"DOLPHINWIF", b"SmilingDolphinWifHat", b"literally just Smiling Dolphin wif a hat!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Z09f_Wtb6_400x400_654d2172b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPHINWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLPHINWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

