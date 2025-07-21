module 0x60e151f61420f4f782a7c0edb275a2e6eb8476aa6a864b15e2fc82cf2f33e9e3::sail_token {
    struct SAIL_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAIL_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SAIL_TOKEN>(arg0, 6, b"SAIL", b"Full Sail", b"Full Sail Governance Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.fullsail.finance/static_files/sail_coin.png")), true, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAIL_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SAIL_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAIL_TOKEN>>(v2);
    }

    // decompiled from Move bytecode v6
}

