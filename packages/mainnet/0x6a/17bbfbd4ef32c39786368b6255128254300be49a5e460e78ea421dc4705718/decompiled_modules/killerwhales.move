module 0x6a17bbfbd4ef32c39786368b6255128254300be49a5e460e78ea421dc4705718::killerwhales {
    struct KILLERWHALES has drop {
        dummy_field: bool,
    }

    fun init(arg0: KILLERWHALES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KILLERWHALES>(arg0, 6, b"KillerWhales", b"Killer Whale", b"Forget Pepe. The future belongs to $KWHALE. Launching on the SUI chain, this isn't just a memecoin; it's a movement. Join the wave, grab your share, and ride the $KWHALE to the moon. The time for domination is now.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_1_0c0c602b24.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KILLERWHALES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KILLERWHALES>>(v1);
    }

    // decompiled from Move bytecode v6
}

