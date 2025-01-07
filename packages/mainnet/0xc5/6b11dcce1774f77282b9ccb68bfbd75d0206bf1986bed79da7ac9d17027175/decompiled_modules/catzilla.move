module 0xc56b11dcce1774f77282b9ccb68bfbd75d0206bf1986bed79da7ac9d17027175::catzilla {
    struct CATZILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATZILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATZILLA>(arg0, 6, b"CATZILLA", b"Catzilla", b"Prepare yourself for the ultimate clash of cuteness and chaos with Catzilla! This isn't just any ordinary tokenthis is the one that roars its way onto the SUI blockchain with the mighty, earth-shaking force of a catzilla-sized purr. Imagine a chubby, adorable kitten donning a Godzilla costume, stomping through the crypto world, leaving a trail of \"SKREEONK!\" and awe in its wake.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_08_22_08_56_19_2e8f31a9a4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATZILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATZILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

