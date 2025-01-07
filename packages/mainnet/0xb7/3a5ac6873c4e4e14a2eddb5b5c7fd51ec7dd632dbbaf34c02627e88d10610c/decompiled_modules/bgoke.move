module 0xb73a5ac6873c4e4e14a2eddb5b5c7fd51ec7dd632dbbaf34c02627e88d10610c::bgoke {
    struct BGOKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BGOKE>(arg0, 6, b"BGOKE", b"SUI BGOKE", b"Bgoke is a legendary character  a once successful stock trader who plunged into the world of crypto to make his dream (Lambo) come true. Several scams and rugs cooked him so hard. The final blow was a drainer that stole the last $87 from his wallet. Now, he's completely broke and working a 5/2 job at BDonalds.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BGOKE_2_ea224ed83d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BGOKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BGOKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

