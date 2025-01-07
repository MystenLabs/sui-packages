module 0x4723b51ee2877f736ac077a506120488876eeed0f80b7b7a8398739f2900399d::dogwifchain {
    struct DOGWIFCHAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGWIFCHAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGWIFCHAIN>(arg0, 6, b"DOGWIFCHAIN", b"Dog Wif Chain", b"Introducing $DOGWIFCHAIN, 2 days ago, I met the scariest dog. Dude ripped a metal chain apart, eyes blazing red, and came straight at me. I ran like hell. Now he's on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d_4b58944b2a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGWIFCHAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGWIFCHAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

