module 0x6c1093494dd374c07519523be790bf8db342644258e8a4138a748d708f320fdd::rznde {
    struct RZNDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RZNDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RZNDE>(arg0, 6, b"RZNDE", b"Rezendeevil Token", b"The Official SUI Meme coin Token of Rezendeevil. Brazilian YouTuber with over 58 million combined followers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/546456_eaeecd2f85.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RZNDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RZNDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

