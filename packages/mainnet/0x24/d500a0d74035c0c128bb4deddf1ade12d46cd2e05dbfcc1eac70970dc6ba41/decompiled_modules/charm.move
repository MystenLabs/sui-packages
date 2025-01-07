module 0x24d500a0d74035c0c128bb4deddf1ade12d46cd2e05dbfcc1eac70970dc6ba41::charm {
    struct CHARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHARM>(arg0, 6, b"Charm", b"CharmanderSUI", b"CharmSui is a fire-charged cryptocurrency on the SUI blockchain, sparking innovation and electrifying the crypto world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000196881_479a205078.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHARM>>(v1);
    }

    // decompiled from Move bytecode v6
}

