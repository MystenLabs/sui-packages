module 0xbb276ae9a0f59df8f460dab12c8b8069e05bf3fddfeb243c4c2b6b3c4f644e78::cthulu {
    struct CTHULU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTHULU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTHULU>(arg0, 6, b"CTHULU", b"Cthulu on Sui", b"The eldergod of Sui that will rule over all of crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_d4fd9182c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTHULU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTHULU>>(v1);
    }

    // decompiled from Move bytecode v6
}

