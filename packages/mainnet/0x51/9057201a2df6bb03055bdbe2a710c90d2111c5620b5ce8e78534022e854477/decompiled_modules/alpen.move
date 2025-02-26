module 0x519057201a2df6bb03055bdbe2a710c90d2111c5620b5ce8e78534022e854477::alpen {
    struct ALPEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALPEN>(arg0, 9, b"ALPEN", b"Alpen Token", b"A token for the Alpen project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ALPEN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPEN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALPEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

