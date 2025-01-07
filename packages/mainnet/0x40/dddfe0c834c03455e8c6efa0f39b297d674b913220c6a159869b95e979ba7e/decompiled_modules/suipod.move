module 0x40dddfe0c834c03455e8c6efa0f39b297d674b913220c6a159869b95e979ba7e::suipod {
    struct SUIPOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPOD>(arg0, 10, b"SUIPOD", b"POD", b"SUIS FIRST MEME COIN ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIPOD>(&mut v2, 999999990000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPOD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

