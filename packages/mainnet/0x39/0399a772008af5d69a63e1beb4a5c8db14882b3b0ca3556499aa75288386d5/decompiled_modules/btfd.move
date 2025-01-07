module 0x390399a772008af5d69a63e1beb4a5c8db14882b3b0ca3556499aa75288386d5::btfd {
    struct BTFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTFD>(arg0, 6, b"BTFD", b"Buy The Fucking Dip", b"The narrative is simple. You see the dip, you buy!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/portal_4369ae744b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

