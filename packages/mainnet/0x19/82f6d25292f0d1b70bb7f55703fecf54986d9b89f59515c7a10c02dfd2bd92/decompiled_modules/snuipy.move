module 0x1982f6d25292f0d1b70bb7f55703fecf54986d9b89f59515c7a10c02dfd2bd92::snuipy {
    struct SNUIPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNUIPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNUIPY>(arg0, 6, b"Snuipy", b"SNUIPY on SUI", b"Everyone's favorite beagle, Snuipy is here to sniff out new opportunities on the SUI. He also cool af.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_26_at_11_19_08_0a908e2dab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNUIPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNUIPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

