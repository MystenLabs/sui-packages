module 0x2fa4f4298713e356fbc4361fbfb1e9165b2949b757902795b53698be5698689e::bufo {
    struct BUFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUFO>(arg0, 6, b"BUFO", b"BUFO COIN", b"Bufo wants you to buy his coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bufo_Coin_5537d05d43.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUFO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUFO>>(v1);
    }

    // decompiled from Move bytecode v6
}

