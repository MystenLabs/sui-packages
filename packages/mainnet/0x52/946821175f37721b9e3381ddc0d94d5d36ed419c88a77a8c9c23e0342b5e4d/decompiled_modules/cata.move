module 0x52946821175f37721b9e3381ddc0d94d5d36ed419c88a77a8c9c23e0342b5e4d::cata {
    struct CATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATA>(arg0, 6, b"CATA", b"CATALORIAN", b"WELCOM TO THE GREAT ARMY CATALORIAN !!! BEST COMMUNITY ON SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/333_4e040bde27.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATA>>(v1);
    }

    // decompiled from Move bytecode v6
}

