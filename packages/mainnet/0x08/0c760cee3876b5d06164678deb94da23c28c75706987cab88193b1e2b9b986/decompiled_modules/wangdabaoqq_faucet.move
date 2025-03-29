module 0x80c760cee3876b5d06164678deb94da23c28c75706987cab88193b1e2b9b986::wangdabaoqq_faucet {
    struct WANGDABAOQQ_FAUCET has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WANGDABAOQQ_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WANGDABAOQQ_FAUCET>>(0x2::coin::mint<WANGDABAOQQ_FAUCET>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: WANGDABAOQQ_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WANGDABAOQQ_FAUCET>(arg0, 8, b"WANGDABAOQQ_FAUCET", b"WANGDABAOQQ_FAUCET", b"Move coin by WANGDABAOQQ_FAUCET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/17332298")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WANGDABAOQQ_FAUCET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WANGDABAOQQ_FAUCET>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

