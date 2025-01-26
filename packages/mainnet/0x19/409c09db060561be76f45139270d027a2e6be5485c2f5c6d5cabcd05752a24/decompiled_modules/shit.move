module 0x19409c09db060561be76f45139270d027a2e6be5485c2f5c6d5cabcd05752a24::shit {
    struct SHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIT>(arg0, 9, b"SHIT", b"FIRST SHITCOIN LAUNCHED BY SHIT", b"FIRST SHITCOIN LAUNCHED BY SHIT (real)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmbav1Lv2gfXaZfUk5BAaWZ4FLfiJeNjAEwZ9RUpAgaHWU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHIT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

