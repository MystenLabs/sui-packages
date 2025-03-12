module 0x9d7ca24f027f5200037de70491371b28600d8f347b7c0577b8a16121d40898ae::open {
    struct OPEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPEN>(arg0, 9, b"OPEN", b"Open Token", b"A new token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OPEN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPEN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OPEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

