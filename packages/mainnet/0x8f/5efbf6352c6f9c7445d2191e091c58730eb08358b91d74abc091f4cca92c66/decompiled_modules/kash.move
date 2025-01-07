module 0x8f5efbf6352c6f9c7445d2191e091c58730eb08358b91d74abc091f4cca92c66::kash {
    struct KASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: KASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KASH>(arg0, 6, b"KASH", b"FBI DIRECTOR $KASH PATEL", b"token dedicated to based FBI Director Kash Patel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241203_222920_167_88a942f8ad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

