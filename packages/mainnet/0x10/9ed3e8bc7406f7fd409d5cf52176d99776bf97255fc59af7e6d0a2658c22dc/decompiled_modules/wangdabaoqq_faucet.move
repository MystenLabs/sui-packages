module 0x109ed3e8bc7406f7fd409d5cf52176d99776bf97255fc59af7e6d0a2658c22dc::wangdabaoqq_faucet {
    struct WANGDABAOQQ_FAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: WANGDABAOQQ_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WANGDABAOQQ_FAUCET>(arg0, 8, b"WANGDABAOQQ_FAUCET", b"WANGDABAOQQ_FAUCET", b"Move coin by WANGDABAOQQ_FAUCET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/17332298")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WANGDABAOQQ_FAUCET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WANGDABAOQQ_FAUCET>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

