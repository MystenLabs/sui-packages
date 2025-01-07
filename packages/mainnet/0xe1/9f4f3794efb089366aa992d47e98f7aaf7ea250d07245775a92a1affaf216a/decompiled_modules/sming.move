module 0xe19f4f3794efb089366aa992d47e98f7aaf7ea250d07245775a92a1affaf216a::sming {
    struct SMING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMING>(arg0, 6, b"SMING", b"SUI MING", b"Yao Ming Meme token on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tanpa_judul_59_202410121906_27658_49d0f956ae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMING>>(v1);
    }

    // decompiled from Move bytecode v6
}

