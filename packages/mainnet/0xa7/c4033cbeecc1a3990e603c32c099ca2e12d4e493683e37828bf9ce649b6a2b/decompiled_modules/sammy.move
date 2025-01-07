module 0xa7c4033cbeecc1a3990e603c32c099ca2e12d4e493683e37828bf9ce649b6a2b::sammy {
    struct SAMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMMY>(arg0, 6, b"SAMMY", b"Sam The Seahorse", b"Sam is kind of a shy seahorse, he is here to make some frens, and build a community so he can fullfill his dream of being the King Of The Sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_2_b1d8ca4517.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

