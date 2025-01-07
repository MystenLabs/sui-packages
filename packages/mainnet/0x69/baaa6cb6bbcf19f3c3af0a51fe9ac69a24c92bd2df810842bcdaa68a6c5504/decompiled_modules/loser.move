module 0x69baaa6cb6bbcf19f3c3af0a51fe9ac69a24c92bd2df810842bcdaa68a6c5504::loser {
    struct LOSER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOSER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOSER>(arg0, 6, b"LOSER", b"Fuck you SUIPUMP", b"Buy and lose money, you stinky piece of crap!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_19_132030_a452e1f570.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOSER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOSER>>(v1);
    }

    // decompiled from Move bytecode v6
}

