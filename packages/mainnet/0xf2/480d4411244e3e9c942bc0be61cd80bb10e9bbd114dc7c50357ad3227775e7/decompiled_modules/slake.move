module 0xf2480d4411244e3e9c942bc0be61cd80bb10e9bbd114dc7c50357ad3227775e7::slake {
    struct SLAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLAKE>(arg0, 6, b"SLAKE", b"SLAKE ON SUI", b"Welcome to Slake on Sui, a blue Matt Furie-inspired character. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/slakelogo_44d6476bec.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

