module 0xd724a968df347caec85cf5987dc492b0880d7dafe1cc509de5348c881a98c553::xavier {
    struct XAVIER has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAVIER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XAVIER>(arg0, 6, b"XAVIER", b"Pakalu Papito", b"Hello cryptoworld, Im single", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pakalu_425caff19e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XAVIER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XAVIER>>(v1);
    }

    // decompiled from Move bytecode v6
}

