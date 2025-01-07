module 0xc69b23547b07c53284c532b0103d6eeaf3f9935fabfaeb6cb785a8bcbd4f0a29::SNOOPDOGE {
    struct SNOOPDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOOPDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOOPDOGE>(arg0, 6, b"SNOOPDOGE", b"SNOOPDOGE", b"Find Our Community On Discord", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/ClNfMPT.jpeg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SNOOPDOGE>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOOPDOGE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOOPDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

