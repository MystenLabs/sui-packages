module 0x46bc84688aa2637b749200f41394da5dd33f6f014994d084b3161c1eda2f8030::dbzy {
    struct DBZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBZY>(arg0, 6, b"Dbzy", b"Dubzy", b"Crypto trader & investor group ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1920_e5673639c1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DBZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

