module 0x5d8fd022bcac32aa21c017c387ce180e49999c4b1b37964e753f036cae5d3b86::sun {
    struct SUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUN>(arg0, 6, b"SUN", b"SUI INU", b"Sui Inu is Shiba Inu's lil brother. He is blinged out and ready for altcoin season.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_inu2_b1e316077d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

