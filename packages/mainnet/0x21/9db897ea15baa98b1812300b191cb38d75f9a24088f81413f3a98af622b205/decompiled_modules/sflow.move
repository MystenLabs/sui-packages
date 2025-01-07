module 0x219db897ea15baa98b1812300b191cb38d75f9a24088f81413f3a98af622b205::sflow {
    struct SFLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFLOW>(arg0, 9, b"SFLOW", b"SuiFlowX", b"The flow of Sui is upon us!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SFLOW>(&mut v2, 200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFLOW>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFLOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

