module 0x18abf3024c50dc41d1c43c34d73d86810cadc96376eba6e7c7f579fac2002fed::boys {
    struct BOYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOYS>(arg0, 6, b"BOYS", b"SUI BOYS CLUB", b"On the Sui blockchain, the Boys Club token emerged as a tribute to Matt Furies iconic Boys Club comic.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/web1_17b5f38b9e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

