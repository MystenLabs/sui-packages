module 0xb95189c382a1dbdef712ef325b03769cd743e00ef15eedb4a77933b68d9aa35c::duckai {
    struct DUCKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKAI>(arg0, 9, b"DuckAI", b"Donald Duck AI", b"A duck AI agent that will help you invest and manage your finances!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYdvAux4MTmGtcxJNJCE2KHECxCZKf69xtyzD4eCcwgcK")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DUCKAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUCKAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

