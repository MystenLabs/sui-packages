module 0x6d26a58a87f5dbbf4903a047565aaaca26d92b63fa97651e8db886df88035b7d::mtv {
    struct MTV has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTV>(arg0, 6, b"MTV", b"MEME TV", b"The ultimate shitposting sanctuary has arrived!  We're bringing non-stop video memes straight to your eyeballs  100% degen-approved.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aa_ea3472b1ba.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MTV>>(v1);
    }

    // decompiled from Move bytecode v6
}

