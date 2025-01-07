module 0x8b98ce4b52cab7f275a2637419d058c99fcdc4350363af5ada122ed013b75e15::pat {
    struct PAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAT>(arg0, 6, b"PAT", b"pat", b"PAT is a lovable cartoon cat and the loyal companion of Pepe the Frog, with his original house located at the SUI chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_03_12_15_db9d88f92e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

