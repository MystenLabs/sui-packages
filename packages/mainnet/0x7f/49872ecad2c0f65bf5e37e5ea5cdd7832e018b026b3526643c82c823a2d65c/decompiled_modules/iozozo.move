module 0x7f49872ecad2c0f65bf5e37e5ea5cdd7832e018b026b3526643c82c823a2d65c::iozozo {
    struct IOZOZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: IOZOZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IOZOZO>(arg0, 6, b"IOZOZO", b"Oizozo", b"Iozozo the 1st Ice Cream Memecoin on Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018591_00da6813b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IOZOZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IOZOZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

