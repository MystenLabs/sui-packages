module 0x13c5b2d9845af35336add69014689fcc258e4fb0552bf25b23d1f8ca16be3996::sptk {
    struct SPTK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPTK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPTK>(arg0, 6, b"SPTK", b"SepthikTank", b"Sha pha Ta Ka of sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20241016_230327_1_e71fd2271a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPTK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPTK>>(v1);
    }

    // decompiled from Move bytecode v6
}

