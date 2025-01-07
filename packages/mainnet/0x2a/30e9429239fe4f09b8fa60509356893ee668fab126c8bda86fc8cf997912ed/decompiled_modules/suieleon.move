module 0x2a30e9429239fe4f09b8fa60509356893ee668fab126c8bda86fc8cf997912ed::suieleon {
    struct SUIELEON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIELEON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIELEON>(arg0, 9, b"SUIELEON", b"Serious Suieleon", b"Serious Suieleon is taken seriously regardless of the fact that it will only be a meme. Always ready for FOMO and HYPE  he is here on SUI !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIELEON>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIELEON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIELEON>>(v1);
    }

    // decompiled from Move bytecode v6
}

