module 0xcff5397fcbac9af14ec7fb5b55cc9e012ceb6a49e073b99a0777006a3a52a06f::crt {
    struct CRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRT>(arg0, 6, b"CRT", b"CAROTTOPIA", b"Freshly picked from meme fields, Carottopia is crunching its way to the top. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_025302171_69761590d8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

