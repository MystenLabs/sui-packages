module 0x6d1b9e362c994fccce16fa6ead647b2ba4b6406e76eadbc60921cce89ca730f6::hulk {
    struct HULK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HULK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HULK>(arg0, 6, b"HULK", b"HULK ON SUI", b"THE OFFICIAL HULK ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6870_c91542f842.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HULK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HULK>>(v1);
    }

    // decompiled from Move bytecode v6
}

