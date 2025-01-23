module 0xecd2e27d1e4dce6f5781715b64be4045b9cad48baee06e9cd23db9718064bc21::yahoo {
    struct YAHOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAHOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAHOO>(arg0, 9, b"yahoo", b"DAO", b"LFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/49327fa0-d9bc-11ef-80e8-811f7f414973")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YAHOO>>(v1);
        0x2::coin::mint_and_transfer<YAHOO>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAHOO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

