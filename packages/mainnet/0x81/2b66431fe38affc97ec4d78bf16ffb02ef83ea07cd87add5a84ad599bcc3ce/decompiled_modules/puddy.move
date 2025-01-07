module 0x812b66431fe38affc97ec4d78bf16ffb02ef83ea07cd87add5a84ad599bcc3ce::puddy {
    struct PUDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUDDY>(arg0, 9, b"PUDDY", b"Puddle", x"2250756464792220285469636b65723a20505544445929206973206120706c617966756c2c20636f6d6d756e6974792d64726976656e20746f6b656e206f6e205375692c2064657369676e656420746f206272696e67206578636974656d656e7420616e642066756e20746f207468652063727970746f20776f726c642e204974e280997320616c6c2061626f75742067726f7774682c2073706f6e74616e656974792c20616e64206d616b696e6720612073706c61736821", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1688539102646312961/npc4LM1n.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUDDY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUDDY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

