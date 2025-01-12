module 0x8480f382d3167e6048cffe95eb7c57b713755ef1f648745063bf8ff9f2bd120a::bsdbsd {
    struct BSDBSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSDBSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSDBSD>(arg0, 6, b"bsdbsd", b"dvsb", b"sbdbdsb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/77cd2e07-b5aa-4a35-9495-c8cadb1f47eb.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSDBSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSDBSD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

