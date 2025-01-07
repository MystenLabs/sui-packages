module 0x7fbe0c8b7aa8ef0aacf5a749a659c8a65c33943ca9028ec6edd5655f5ba51f2d::hopfunny {
    struct HOPFUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPFUNNY>(arg0, 6, b"HOPFUNNY", b"FUNNY HOPHOP", b"Are you Prepared for the Biggest #SUI Meme launch of the Year!!  Set your reminders ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018271_e3ef88d872.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPFUNNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPFUNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

