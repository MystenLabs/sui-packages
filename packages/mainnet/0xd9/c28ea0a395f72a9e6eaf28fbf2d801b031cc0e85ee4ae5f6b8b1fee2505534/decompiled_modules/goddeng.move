module 0xd9c28ea0a395f72a9e6eaf28fbf2d801b031cc0e85ee4ae5f6b8b1fee2505534::goddeng {
    struct GODDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODDENG>(arg0, 6, b"GODDENG", b"GOD DENG REAL", b"You missed out on Moo Deng? God Deng!!! This is your last chance.Be cautious of fraudulent contracts !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_tick_bab7a1ad4a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GODDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

