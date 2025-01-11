module 0x36756bd638cdfa98c5b96c33645319fbb491d77548cc9d090be43bbe7e265430::suituk {
    struct SUITUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITUK>(arg0, 6, b"SUITUK", b"Suituk", b"while youre out and about searching for your next play, dont get Suituk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000058612_d01731bf6f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

