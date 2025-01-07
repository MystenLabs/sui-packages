module 0xec86a93540ac646dfd0edae226ff10486a042667292705aca8448f6583666951::suifuckyoucrash {
    struct SUIFUCKYOUCRASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFUCKYOUCRASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFUCKYOUCRASH>(arg0, 6, b"SUIFUCKYOUCRASH", b"FUCKYOUCRASH", b"FUCK YOU CRASH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ga_It_D_5_Xk_AASRBP_c81cb847dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFUCKYOUCRASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFUCKYOUCRASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

