module 0xa68ad9c628a1cbb3881c2dee315737a4b861ed5efb895ed801f9d0f05e322c6d::dscam {
    struct DSCAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSCAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSCAM>(arg0, 1, b"DSCAM", b"Daoscam", b"DAOSRUG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/1d7af590-d985-11ef-80e8-811f7f414973")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSCAM>>(v1);
        0x2::coin::mint_and_transfer<DSCAM>(&mut v2, 11000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSCAM>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

