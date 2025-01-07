module 0x369b9a8a1aaa7c22d48883310b351eacdaf51c6f77aafc6466f035bbf458e369::winner {
    struct WINNER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINNER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINNER>(arg0, 9, b"WINNER", b"WIN", b"WIN AND ONE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.freepik.com/premium-vector/win-celebration-jackpot-lettering-isolated-white-colourful-text-effect-design-vector-text-inscriptions-english-modern-creative-design-has-red-orange-yellow-colors_7280-8197.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WINNER>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINNER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WINNER>>(v1);
    }

    // decompiled from Move bytecode v6
}

