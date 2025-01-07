module 0x6a7e04bc5e5ee6918c2e4c03a138d6b07b7cf506073db0bfca4f524586830d03::suidan {
    struct SUIDAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDAN>(arg0, 6, b"SUIDAN", b"LT. Lego Dan", b"Who need's legs when your riding the suinami.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suidan_28e00c55c0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

