module 0x5169353281acb52fc217a30cd6cd829a176c55f6c3c246a4e9c63f283f9ca21c::torki {
    struct TORKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORKI>(arg0, 9, b"Torki", b"Torki", b"The game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TORKI>(&mut v2, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORKI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TORKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

