module 0xe49de911195e491a0dba2911d4ec69c245252ddc33132b2528b473e16feacb1f::suineo {
    struct SUINEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINEO>(arg0, 6, b"SUINEO", b"Suineo", b"$SUINEO is that flashy token everyones talking about, rolling up on the SUI blockchain like it owns the place. Just like Suneo from Doraemon, its all about flexing, bragging, and showing off its crypto stacks. If you wanna roll with the coolest crew on SUI, $SUINEOs where its at get in, were ruling this chain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/profpic_suineo_dff79971bf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

