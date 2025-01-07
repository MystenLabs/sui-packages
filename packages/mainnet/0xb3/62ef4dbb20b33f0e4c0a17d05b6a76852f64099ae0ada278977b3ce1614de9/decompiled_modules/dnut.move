module 0xb362ef4dbb20b33f0e4c0a17d05b6a76852f64099ae0ada278977b3ce1614de9::dnut {
    struct DNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNUT>(arg0, 6, b"DNUT", b"Deez Nuts on Sui", x"57686f7320746865204465763f204465657a204e757473212e2e20476f7420456d0a446f6e74206a65657420796f7572206e75747321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5371_f061e73f29.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

