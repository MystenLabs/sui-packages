module 0x6d0db23dac3723568f13df16961e2c904aa0064b2ffbce816e91759d6f379f80::lfg {
    struct LFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LFG>(arg0, 9, b"LFG", b"LFG", b"LFG SUI LFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1671247989455683585/SGKA_txr_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LFG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LFG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LFG>>(v1);
    }

    // decompiled from Move bytecode v6
}

