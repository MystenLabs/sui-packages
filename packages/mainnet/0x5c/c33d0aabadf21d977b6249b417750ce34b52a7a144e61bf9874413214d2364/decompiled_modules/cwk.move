module 0x5cc33d0aabadf21d977b6249b417750ce34b52a7a144e61bf9874413214d2364::cwk {
    struct CWK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWK>(arg0, 6, b"CWK", b"crab with knife", b"https://youtu.be/0QaAKi0NFkA?si=1p1LQePdyXJ8dygW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0150_e48d84bcb0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CWK>>(v1);
    }

    // decompiled from Move bytecode v6
}

