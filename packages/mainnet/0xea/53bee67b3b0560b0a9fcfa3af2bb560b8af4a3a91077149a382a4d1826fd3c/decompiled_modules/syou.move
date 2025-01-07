module 0xea53bee67b3b0560b0a9fcfa3af2bb560b8af4a3a91077149a382a4d1826fd3c::syou {
    struct SYOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYOU>(arg0, 6, b"SYOU", b"SYOBON SUI", b"Just Syobon on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bons_57e47dfd13.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

