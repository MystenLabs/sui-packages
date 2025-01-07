module 0x4c82a8b887b312cfcbcc6311b2a0821f32caf5c77fdab379f70d619c597cccf7::mot {
    struct MOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOT>(arg0, 6, b"MOT", b"Meme Of Thrones", b"Meme of Thrones is an animated parody series inspired by Game of Thrones, featuring popular meme characters from the crypto community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002198_9d1ec29442.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

