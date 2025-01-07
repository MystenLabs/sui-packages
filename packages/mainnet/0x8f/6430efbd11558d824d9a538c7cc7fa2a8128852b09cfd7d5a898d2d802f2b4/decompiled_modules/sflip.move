module 0x8f6430efbd11558d824d9a538c7cc7fa2a8128852b09cfd7d5a898d2d802f2b4::sflip {
    struct SFLIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFLIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFLIP>(arg0, 6, b"SFLIP", b"SUIFLIP", b"Meme coin+Coin Flip", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hzilu_Hg_O_400x400_d7c762a3b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFLIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFLIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

