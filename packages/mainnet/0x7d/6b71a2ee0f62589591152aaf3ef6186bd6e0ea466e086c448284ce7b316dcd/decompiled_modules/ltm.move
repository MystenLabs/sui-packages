module 0x7d6b71a2ee0f62589591152aaf3ef6186bd6e0ea466e086c448284ce7b316dcd::ltm {
    struct LTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: LTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LTM>(arg0, 9, b"LTM", b"LITIUM", b"ge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://thumbs.dreamstime.com/z/lithium-as-element-periodic-table-d-animation-blue-background-d-illustration-lithium-as-element-periodic-table-179570113.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LTM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LTM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LTM>>(v1);
    }

    // decompiled from Move bytecode v6
}

