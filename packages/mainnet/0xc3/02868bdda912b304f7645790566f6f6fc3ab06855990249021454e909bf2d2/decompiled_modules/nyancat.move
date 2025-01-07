module 0xc302868bdda912b304f7645790566f6f6fc3ab06855990249021454e909bf2d2::nyancat {
    struct NYANCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYANCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYANCAT>(arg0, 6, b"NYANCAT", b"Nyan Cat", b"The OG NyanCat meme made famous around the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nya_N_70115b19da.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYANCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NYANCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

