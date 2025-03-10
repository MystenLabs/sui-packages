module 0x485911efdf455882257e89378eb0c7b537133492da9e2ec19fe4fa6cf719cbb9::nick {
    struct NICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NICK>(arg0, 9, b"NICK", b"Nick", b"A token named Nick.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NICK>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NICK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

