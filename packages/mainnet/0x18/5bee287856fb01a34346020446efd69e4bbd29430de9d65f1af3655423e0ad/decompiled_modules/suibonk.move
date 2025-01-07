module 0x185bee287856fb01a34346020446efd69e4bbd29430de9d65f1af3655423e0ad::suibonk {
    struct SUIBONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBONK>(arg0, 9, b"SUIBONK", b"Sui Bonk", b"Bonk Is meme on solana , now on Sui chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1844204590277021696/lhMfssBk.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBONK>(&mut v2, 440000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBONK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

