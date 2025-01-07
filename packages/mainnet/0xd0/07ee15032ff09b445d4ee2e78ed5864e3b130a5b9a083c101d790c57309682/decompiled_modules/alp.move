module 0xd007ee15032ff09b445d4ee2e78ed5864e3b130a5b9a083c101d790c57309682::alp {
    struct ALP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALP, arg1: &mut 0x2::tx_context::TxContext) {
        0xd007ee15032ff09b445d4ee2e78ed5864e3b130a5b9a083c101d790c57309682::admin::create_admin_cap(arg1);
        let (v0, v1) = 0x2::coin::create_currency<ALP>(arg0, 6, b"ALP", b"ABEx LP Token", b"LP Token for ABEx Market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/_doZFc5BTE7z9RXATSRI0yN5tUC69jZqwoLflk2vQu8")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALP>>(v1);
        0xd007ee15032ff09b445d4ee2e78ed5864e3b130a5b9a083c101d790c57309682::market::create_market<ALP>(0x2::coin::treasury_into_supply<ALP>(v0), 0xd007ee15032ff09b445d4ee2e78ed5864e3b130a5b9a083c101d790c57309682::rate::from_percent(5), arg1);
    }

    // decompiled from Move bytecode v6
}

