module 0xf20c48d71d73b336b84f58dc9332e33eecf866c8bb4cfe660c2ae6d9260a6c4b::drive {
    struct DRIVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRIVE>(arg0, 6, b"DRIVE", b"SuiDriverS", b"Dave runs a bar in DiverS, where divers gather to rest and share stories. Its the perfect place to meet your diver. Dave's bar is a key feature for recruiting Divers in the game.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000072151_4062b2f4c7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRIVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRIVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

