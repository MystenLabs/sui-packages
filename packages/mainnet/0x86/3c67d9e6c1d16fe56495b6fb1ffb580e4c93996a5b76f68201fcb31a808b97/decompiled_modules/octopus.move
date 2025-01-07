module 0x863c67d9e6c1d16fe56495b6fb1ffb580e4c93996a5b76f68201fcb31a808b97::octopus {
    struct OCTOPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTOPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTOPUS>(arg0, 6, b"OCTOPUS", b"Octopus on Sui", b"Sui Octopus swims through the Sui Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/octopus_cefcb96699.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOPUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTOPUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

