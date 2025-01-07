module 0x2436e151b62474ddbdc34a317ee0baa484a45bceed4991bcd28bdcdeccc46c74::suinator {
    struct SUINATOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINATOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINATOR>(arg0, 3, b"SUINATOR", b"SUINATOR", b"SUI protector", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUINATOR>(&mut v2, 69000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINATOR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINATOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

