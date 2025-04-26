module 0x301c87664544eeeaa140a2ed15ff7ace650bb4d6829fe558e90999337b5fcb52::crhds {
    struct CRHDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRHDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRHDS>(arg0, 6, b"CRHDS", b"CRAZY HEADS", b"In a world full of copy-paste tokens, Crazy Heads comes swinging with no filter, no brakes, and no apologies. Were the voice of the chaotic, the misunderstood, the terminally online degenerates who see the charts as a playground and memes as religion.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karakter_Unik_di_Lanskap_Digital_fcf15eb424.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRHDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRHDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

