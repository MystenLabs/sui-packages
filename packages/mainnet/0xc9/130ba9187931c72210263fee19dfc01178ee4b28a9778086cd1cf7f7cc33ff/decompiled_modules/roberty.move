module 0xc9130ba9187931c72210263fee19dfc01178ee4b28a9778086cd1cf7f7cc33ff::roberty {
    struct ROBERTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBERTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBERTY>(arg0, 6, b"ROBERTY", b"The Statue of Roberty", b"$ROBERTY - Once symbol of liberty, now gone rogue.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul42_20241223010427_c4b5461b10.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBERTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBERTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

