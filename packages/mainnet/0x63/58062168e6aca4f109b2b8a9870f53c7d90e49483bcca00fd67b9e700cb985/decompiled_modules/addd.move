module 0x6358062168e6aca4f109b2b8a9870f53c7d90e49483bcca00fd67b9e700cb985::addd {
    struct ADDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADDD>(arg0, 9, b"ADDD", b"SADD", b"SADD ADD ADD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ADDD>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADDD>>(v2, @0x191726a4470b439a8353879cbcb7a67617e78ef938eb3b8cd5a0cf1cf285ce8f);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

