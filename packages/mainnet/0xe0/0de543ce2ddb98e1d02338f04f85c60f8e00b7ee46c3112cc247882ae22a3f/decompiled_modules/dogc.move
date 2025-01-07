module 0xe00de543ce2ddb98e1d02338f04f85c60f8e00b7ee46c3112cc247882ae22a3f::dogc {
    struct DOGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGC>(arg0, 9, b"DOGC", b"DOGCAP", b"DOGS LOVER COMMUNITY TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOGC>(&mut v2, 4000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGC>>(v1);
    }

    // decompiled from Move bytecode v6
}

