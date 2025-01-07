module 0x512c66436b9c36d1bb3f70e53e2a1c7c4c3aa65e7edafdae7f93c4754552a188::pengs {
    struct PENGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGS>(arg0, 6, b"PENGS", b"PENGSUI", b"PengSuin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1537fb23_4a14_4429_a909_8e28d20f4f49_8aa3a1e451.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

