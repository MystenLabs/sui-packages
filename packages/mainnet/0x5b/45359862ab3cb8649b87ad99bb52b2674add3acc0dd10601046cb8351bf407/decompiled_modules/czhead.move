module 0x5b45359862ab3cb8649b87ad99bb52b2674add3acc0dd10601046cb8351bf407::czhead {
    struct CZHEAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZHEAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CZHEAD>(arg0, 6, b"CZHEAD", b"Crazy Heads", b"In a world full of copy-paste tokens, Crazy Heads comes swinging with no filter, no brakes, and no apologies. Were the voice of the chaotic, the misunderstood, the terminally online degenerates who see the charts as a playground and memes as religion.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karakter_Unik_di_Lanskap_Digital_4216ec4dbc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZHEAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CZHEAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

