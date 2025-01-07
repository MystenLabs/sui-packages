module 0x2a519bcedf20d1c3229f5671199f5f119e01a6ea1f4781a2e8b33b2628f8f74a::ratty {
    struct RATTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATTY>(arg0, 6, b"RATTY", b"Ratty Cry", b"PLEASE HELP THIS RAT AND BUY BUY BUY BUY BUY!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rat_cry_mouse_cutie_f808736440.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RATTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

