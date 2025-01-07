module 0x7cbf3658011cf23f91e18a4cd285959a23206426c20c58dd6612d0a4f82bde55::swi {
    struct SWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWI>(arg0, 6, b"SWI", b"SuiWoman Inu", b"SuiWoman Inu is a meme project that aims to bring laughter, joy, and a healthy dose of absurdity to the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_fd96e7248c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

