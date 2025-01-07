module 0x3fda5746b2ca4f35c751f912637f2aca3be56d259ce6696747dfad5838554784::dont_buy_this_shit {
    struct DONT_BUY_THIS_SHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONT_BUY_THIS_SHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONT_BUY_THIS_SHIT>(arg0, 6, b"DON'T BUY THIS SHIT", b"SHIT", b"Why are you even reading this?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://orange-pale-condor-574.mypinata.cloud/ipfs/QmPSQ5Gd8o1MjGSSq6izeVUtfad6bWxzfMeU18Zx6MuLTX")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DONT_BUY_THIS_SHIT>(&mut v2, 69000000000 * 1000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONT_BUY_THIS_SHIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONT_BUY_THIS_SHIT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

