module 0xbebe19cbf9c8cc82db65805ca64a72c52817489964a7f4c7639cbc9322d2bb63::cwhale {
    struct CWHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWHALE>(arg0, 9, b"CWHALE", b"Chill Whale", b"$WHALE where power meets limitless opportunities!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.degencdn.com/ipfs/bafkreientgmkpipx2kgzglxawnbzuul7bn5wmohemkdtnyx3flafat5nti")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CWHALE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CWHALE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWHALE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

