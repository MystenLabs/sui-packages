module 0xce7dcbb774ad44eb811d87380a030d07f5191a9dcd88eb0f29f6d0fc2507178b::mot {
    struct MOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOT>(arg0, 6, b"MOT", b"Meme Of Thrones", b"Meme of Thrones is an animated parody series inspired by Game of Thrones, featuring popular meme characters from the crypto community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002265_3405f54486.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

