module 0xf1452b763b3a0e3e3711a91335e93446e34c9516cb222f4dfa2acb276d68fe18::gurmi {
    struct GURMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GURMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GURMI>(arg0, 6, b"Gurmi", b"Gurmi on sui", b"WE ARE NOT LIVE YET! LAUNCHING LATER TODAY! WE WILL ANNOUNCE IN TG A FEW MINUTES BEFORE LAUNCH. DO NOT BUY ANY TOKEN THAT DOES NOT HAVE LIVE WEBSITE! REAL ONE WILL HAVE WEBSITE LIVE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Main_Gurmi_Move_1_c274c820af.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GURMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GURMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

