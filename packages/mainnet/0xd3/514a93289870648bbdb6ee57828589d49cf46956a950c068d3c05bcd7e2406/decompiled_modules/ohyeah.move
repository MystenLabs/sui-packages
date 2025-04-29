module 0xd3514a93289870648bbdb6ee57828589d49cf46956a950c068d3c05bcd7e2406::ohyeah {
    struct OHYEAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: OHYEAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OHYEAH>(arg0, 9, b"OHYEAH", b"Kool-Aid Man Challenge", b"TikTok trend coming back. Kool-Aid man challenge where you full sprint through fences/doors/walls", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQfkZWey4pudfbcvECLoi5jqhy9ywQ4ibJ8tpazwyPEWp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OHYEAH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OHYEAH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OHYEAH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

