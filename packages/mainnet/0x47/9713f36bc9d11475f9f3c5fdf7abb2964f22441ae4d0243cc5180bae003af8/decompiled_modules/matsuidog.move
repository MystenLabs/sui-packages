module 0x479713f36bc9d11475f9f3c5fdf7abb2964f22441ae4d0243cc5180bae003af8::matsuidog {
    struct MATSUIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MATSUIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MATSUIDOG>(arg0, 6, b"Matsuidog", b"matsui dog", b"$matsuidog is a super cute meme token inspired by Japanese artist Matsui! But the coolest part? Its got SUI vibes built right into the nametalk about fate!  Thats right, matsui literally has SUI in it! Not just some random meme coin, were here to let Matsui know his doggos are now the official mascot of the SUI blockchain, shining bright, good luck and going to the moon!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0h_Ykt_RB_400x400_1eeeeeebf8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATSUIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MATSUIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

