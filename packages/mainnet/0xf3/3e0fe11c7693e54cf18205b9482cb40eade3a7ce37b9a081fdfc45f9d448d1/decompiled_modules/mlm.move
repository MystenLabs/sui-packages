module 0xf33e0fe11c7693e54cf18205b9482cb40eade3a7ce37b9a081fdfc45f9d448d1::mlm {
    struct MLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MLM>(arg0, 6, b"MLM", b"Meme Language Model", b"Developers realized that memes werent just jokes; they were a cultural phenomenon, a way to express emotions, ideas, and even complex societal commentary. But traditional AIs couldnt truly understand or create memesthey lacked the cultural context a..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000058409_f0792ad3e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

