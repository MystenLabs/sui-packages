module 0xf8ea84f5814bad430602b78eef63613fc04dac66acee4be708f41f265b6a5e0f::win {
    struct WIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIN>(arg0, 9, b"WIN", b"WIN", b"WIN AND ONE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.freepik.com/premium-vector/win-celebration-jackpot-lettering-isolated-white-colourful-text-effect-design-vector-text-inscriptions-english-modern-creative-design-has-red-orange-yellow-colors_7280-8197.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WIN>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

