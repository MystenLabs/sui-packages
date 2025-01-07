module 0x583546131c8f498309b3cfeed2200ce706d39b714c2215470653f9f70764a081::spidey {
    struct SPIDEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIDEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIDEY>(arg0, 6, b"Spidey", b"SPIDEY THE CUTEST COIN", b"Hi, I'm $Spidey! Are you ready for a really high jump wif me? If you're, then let's gooo!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/spidey_06f171206a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIDEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPIDEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

