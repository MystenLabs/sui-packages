module 0xff790ab83ad1a75c5bcd7500181467d00c0f7d982cb16eda1df06a08de687884::based {
    struct BASED has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASED>(arg0, 6, b"BASED", b"TREMP", b"BASED AGAIN !!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000010402_f2208c0b51.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BASED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BASED>>(v1);
    }

    // decompiled from Move bytecode v6
}

