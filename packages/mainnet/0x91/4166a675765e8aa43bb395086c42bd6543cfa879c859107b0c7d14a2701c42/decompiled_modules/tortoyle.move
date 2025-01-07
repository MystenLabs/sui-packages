module 0x914166a675765e8aa43bb395086c42bd6543cfa879c859107b0c7d14a2701c42::tortoyle {
    struct TORTOYLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORTOYLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORTOYLE>(arg0, 6, b"TORTOYLE", b"TORTOYLE Coin", b"Tortoyle Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ecbtolx2myo_jpg_cd552360c6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORTOYLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TORTOYLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

