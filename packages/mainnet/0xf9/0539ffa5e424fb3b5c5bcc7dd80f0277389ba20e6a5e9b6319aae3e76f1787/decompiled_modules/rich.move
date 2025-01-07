module 0xf90539ffa5e424fb3b5c5bcc7dd80f0277389ba20e6a5e9b6319aae3e76f1787::rich {
    struct RICH has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICH>(arg0, 9, b"RICH", b"Make Me Rich", b"Make Me Rich Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JlAObWl.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RICH>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICH>>(v1);
    }

    // decompiled from Move bytecode v6
}

