module 0x69af3635dbb43b6fb5552807287fdba8d1e6493f40383a2c976c06811e4f6a6d::sjt {
    struct SJT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SJT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SJT>(arg0, 6, b"SJT", b"Suijontrump", b"Surfing, Jonning, and Trumping", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000359689_e2b11811b6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SJT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SJT>>(v1);
    }

    // decompiled from Move bytecode v6
}

