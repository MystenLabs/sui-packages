module 0xe4678e82a0fd385064989fa25e9175168baa2a3a00509b6d0cdbe6257059e6a2::wjdq_faucet {
    struct WJDQ_FAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: WJDQ_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WJDQ_FAUCET>(arg0, 18, b"wjdq faucet", b"wjdqFaucet", b"this is wjdq faucet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/5901419")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WJDQ_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<WJDQ_FAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

