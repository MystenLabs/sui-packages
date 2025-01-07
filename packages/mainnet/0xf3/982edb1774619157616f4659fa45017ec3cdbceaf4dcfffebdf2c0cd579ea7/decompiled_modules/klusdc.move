module 0xf3982edb1774619157616f4659fa45017ec3cdbceaf4dcfffebdf2c0cd579ea7::klusdc {
    struct KLUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x210583b3e0a97aa0da941ad2c73b4ad82580e6097fcbbb699f279045db33d996::equity::create_treasury<KLUSDC>(arg0, 6, b"klUSDC", b"klUSDC", b"Kai Leverage USDC Supply Pool LP Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x53677df4383287aa63b199bf28c6f89f9ddfedc7ca82aa5cb88181db87fdef9b::init::PoolCreationTicket<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, KLUSDC>>(0x53677df4383287aa63b199bf28c6f89f9ddfedc7ca82aa5cb88181db87fdef9b::init::new_pool_creation_ticket<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, KLUSDC>(v0, arg1), v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KLUSDC>>(v1, v2);
    }

    // decompiled from Move bytecode v6
}

