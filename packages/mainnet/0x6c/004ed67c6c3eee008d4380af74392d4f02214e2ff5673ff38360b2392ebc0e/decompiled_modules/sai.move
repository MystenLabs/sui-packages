module 0x6c004ed67c6c3eee008d4380af74392d4f02214e2ff5673ff38360b2392ebc0e::sai {
    struct SAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAI>(arg0, 6, b"SAI", b"SAI ON SUI", b"SAISUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/18802106ab664ddacb73bcd001d27a89_2b9a33e3df.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

