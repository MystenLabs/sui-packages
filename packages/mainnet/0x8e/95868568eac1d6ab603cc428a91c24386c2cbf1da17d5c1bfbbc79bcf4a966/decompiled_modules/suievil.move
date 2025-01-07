module 0x8e95868568eac1d6ab603cc428a91c24386c2cbf1da17d5c1bfbbc79bcf4a966::suievil {
    struct SUIEVIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIEVIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIEVIL>(arg0, 6, b"SUIEVIL", b"Terminal Of Lies", x"4f6e6c792074726f75676820244576696c20776179732c2067726561746e6573732063616e2062652061636869657665642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241209_153707_202_2c120c2e77.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEVIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIEVIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

