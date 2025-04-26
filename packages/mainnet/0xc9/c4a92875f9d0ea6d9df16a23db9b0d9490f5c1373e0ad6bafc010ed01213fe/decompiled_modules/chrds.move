module 0xc9c4a92875f9d0ea6d9df16a23db9b0d9490f5c1373e0ad6bafc010ed01213fe::chrds {
    struct CHRDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHRDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHRDS>(arg0, 6, b"CHRDS", b"CRAZY HEADS", b"In a world full of copy-paste tokens, Crazy Heads comes swinging with no filter, no brakes, and no apologies.  Were the voice of the chaotic, the misunderstood, the terminally online degenerates who see the charts as a playground and memes as religion.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karakter_Unik_di_Lanskap_Digital_2ce0273e1f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHRDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHRDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

