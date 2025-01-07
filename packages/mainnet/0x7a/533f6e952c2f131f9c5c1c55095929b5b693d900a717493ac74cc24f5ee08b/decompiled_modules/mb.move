module 0x7a533f6e952c2f131f9c5c1c55095929b5b693d900a717493ac74cc24f5ee08b::mb {
    struct MB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MB>(arg0, 9, b"MB", b"MutantBlub", b"Mutant Blub is a playful and quirky meme coin inspired by a muted fish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MB>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MB>>(v1);
    }

    // decompiled from Move bytecode v6
}

