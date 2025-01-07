module 0xbdf038ed8241072b88fea6e734a8ac42b6bd456a8ca7959e74f20169967b6d60::gmetoken {
    struct GMETOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMETOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMETOKEN>(arg0, 6, b"GMETOKEN", b"GmE", b"GME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732612767633.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GMETOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMETOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

