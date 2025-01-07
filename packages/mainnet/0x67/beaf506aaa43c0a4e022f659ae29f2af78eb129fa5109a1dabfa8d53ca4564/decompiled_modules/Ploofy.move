module 0x67beaf506aaa43c0a4e022f659ae29f2af78eb129fa5109a1dabfa8d53ca4564::Ploofy {
    struct PLOOFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLOOFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLOOFY>(arg0, 6, b"Ploofy", b"Ploofy", b"Ploofy ! The cutest degen baby whale on the SUI blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://raw.githubusercontent.com/FomoBBoy/images/28d62bf7d3bc7d6dab8ea9ba05c902e7137ebacf/ploofy.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PLOOFY>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLOOFY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLOOFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

