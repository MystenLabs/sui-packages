module 0xb9ad731701c65cb06ea7750cf49b885c29b82257ea28fec6351cbde4e229b5c3::baseddev {
    struct BASEDDEV has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASEDDEV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASEDDEV>(arg0, 9, b"BASEDDEV", b"Dev is based", b"based", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"based")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BASEDDEV>(&mut v2, 6546453000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BASEDDEV>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BASEDDEV>>(v1);
    }

    // decompiled from Move bytecode v6
}

