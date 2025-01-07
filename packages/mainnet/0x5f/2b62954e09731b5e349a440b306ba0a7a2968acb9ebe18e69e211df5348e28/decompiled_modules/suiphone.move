module 0x5f2b62954e09731b5e349a440b306ba0a7a2968acb9ebe18e69e211df5348e28::suiphone {
    struct SUIPHONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPHONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPHONE>(arg0, 6, b"SUIPHONE", b"suiphone", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"suiphone")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIPHONE>(&mut v2, 3200000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPHONE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPHONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

