module 0xc757ee3d4f850df555614c64d4f3ca62742db6af6d636b3221b62745a8054541::blucat {
    struct BLUCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUCAT>(arg0, 6, b"BLUCAT", b"BLUVAT", b"ONLY BLU(e) CAT!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/200w_7fc285d228.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

