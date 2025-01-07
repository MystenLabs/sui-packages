module 0xa8c0f5bc44fade53f681ae38648008a63820bdbf1b5532f312d4178e7eb9c7c::stella {
    struct STELLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: STELLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STELLA>(arg0, 6, b"STELLA", b"STELLA ARTWAH", b"STELLA IS A MISTRESS OF A BEER. SHE COULD FLY, SHE COULD NOT WHO KNOWS. IF YOU BOND HER SHE WILL PAY YOU BACK - QUEEN MEME - ARTWAH SPELT WRONGLY? YEAH WE KNOW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7f35f7ddbcff8e051c09a138aa22f93a_46bacfe19d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STELLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STELLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

