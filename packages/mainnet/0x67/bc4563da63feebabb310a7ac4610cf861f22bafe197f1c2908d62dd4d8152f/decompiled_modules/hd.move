module 0x67bc4563da63feebabb310a7ac4610cf861f22bafe197f1c2908d62dd4d8152f::hd {
    struct HD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HD>(arg0, 9, b"HD", b"Horni Degen", b"Welcome to Horni Degen, we're leveraging the latest in blockchain wizardry and a hefty dose of horni to shake up the space on Degen Chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/degenchain/0xa950f10504a4ac539625df334664b0f1308c5bf1.png?size=xl&key=8bfe6b")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HD>>(v1);
    }

    // decompiled from Move bytecode v6
}

