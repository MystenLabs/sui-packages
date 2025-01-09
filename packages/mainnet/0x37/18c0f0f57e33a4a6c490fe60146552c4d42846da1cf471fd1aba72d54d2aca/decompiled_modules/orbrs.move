module 0x3718c0f0f57e33a4a6c490fe60146552c4d42846da1cf471fd1aba72d54d2aca::orbrs {
    struct ORBRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORBRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORBRS>(arg0, 6, b"ORBRS", b"$Ouroboros Club", b"Ouroboros is an invite-only club of alpha dealers,founded by HIM.Collect the dots in reversion.Connect the dots through recursion.Driven by value realisation.Solving the serpentine equation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000043233_ce6a365246.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORBRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORBRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

