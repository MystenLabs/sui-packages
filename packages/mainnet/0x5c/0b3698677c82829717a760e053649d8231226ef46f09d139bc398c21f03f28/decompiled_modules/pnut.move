module 0x5c0b3698677c82829717a760e053649d8231226ef46f09d139bc398c21f03f28::pnut {
    struct PNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUT>(arg0, 6, b"Pnut", b"Peanut the Squirrel", x"496e206d656d6f7279206f66205065616e7574202d204c6976696e6720666f7265766572206f6e205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_11_13_18_51_23_7d9bfee3e7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

