module 0x46d14ff90bc61d5cd0a0ea86ff0e57e2da448fc6ac56cc3d5385bc252297ee7a::dege {
    struct DEGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGE>(arg0, 6, b"DEGE", b"DEGEonSui", b"For the first time in memecoin history, the people decide what happens next. Dege introduces smart tech that lets the community vote on the future of the project  from utility and partnerships to massive viral events and bold new moves.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibxp5nxyvnz3arrhtdvfx7vdqeajgcrhkwsscuuxktuthqxhrcvza")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DEGE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

