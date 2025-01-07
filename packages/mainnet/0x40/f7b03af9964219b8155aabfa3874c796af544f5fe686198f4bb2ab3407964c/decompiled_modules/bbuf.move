module 0x40f7b03af9964219b8155aabfa3874c796af544f5fe686198f4bb2ab3407964c::bbuf {
    struct BBUF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBUF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBUF>(arg0, 6, b"BBUF", b"BOSSY BUFFALO", b"Big, bold, and always in charge. Bossy Buffalo is leading the meme stampede.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_21_033446231_52bf4f8530.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBUF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBUF>>(v1);
    }

    // decompiled from Move bytecode v6
}

