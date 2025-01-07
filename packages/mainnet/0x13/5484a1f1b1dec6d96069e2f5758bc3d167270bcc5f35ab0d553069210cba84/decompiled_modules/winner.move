module 0x135484a1f1b1dec6d96069e2f5758bc3d167270bcc5f35ab0d553069210cba84::winner {
    struct WINNER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINNER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINNER>(arg0, 6, b"Winner", b"Fuckya", b"Lets fuckin GoOOOOOOOooooOOOOOOOOOO!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fuckya_598ee156c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINNER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WINNER>>(v1);
    }

    // decompiled from Move bytecode v6
}

