module 0x3f59a889be275fd4eec66ca9ee56965328eff1e8fbdca3b6cd57a9e255c023d::eee {
    struct EEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EEE>(arg0, 9, b"EEE", b"EEE", b"eee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EEE>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EEE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

