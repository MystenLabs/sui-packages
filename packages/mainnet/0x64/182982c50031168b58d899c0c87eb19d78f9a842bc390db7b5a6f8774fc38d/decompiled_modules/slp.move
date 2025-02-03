module 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::slp {
    struct SLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLP, arg1: &mut 0x2::tx_context::TxContext) {
        0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::admin::create_admin_cap(arg1);
        let (v0, v1) = 0x2::coin::create_currency<SLP>(arg0, 6, b"SLP", b"Sudo LP Token", b"LP Token for Sudo Market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/_doZFc5BTE7z9RXATSRI0yN5tUC69jZqwoLflk2vQu8")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLP>>(v1);
        0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::market::create_market<SLP>(0x2::coin::treasury_into_supply<SLP>(v0), 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::rate::from_percent(5), arg1);
    }

    // decompiled from Move bytecode v6
}

