module 0xc8b356a5439df3ccc8bef66b96c0d32547040b301baeb91107028550b1fefa83::sammy {
    struct SAMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMMY>(arg0, 6, b"SAMMY", b"Samoyed", b"Strength in silence, unity in purpose", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000271_92a636ffdb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

