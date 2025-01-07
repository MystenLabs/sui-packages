module 0x789a330a91e6a1cc51e9ca5dcf4e0d77d09cb93087a3c9951b7447776967d341::bwob {
    struct BWOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWOB>(arg0, 6, b"BWOB", b"Bwob On Sui", b" $BWOB always had trouble belonging because he didnt have a shape of his own. Thats until he realized that he could be whatever he wanted! He could join anyone on any adventure, fill any role! Bwob is for everyone and is now spreading his wisdom and fortune to all", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250106_040013_326_ada578ff09.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BWOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

