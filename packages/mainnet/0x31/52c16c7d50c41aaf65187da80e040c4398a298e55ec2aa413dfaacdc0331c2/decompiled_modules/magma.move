module 0x3152c16c7d50c41aaf65187da80e040c4398a298e55ec2aa413dfaacdc0331c2::magma {
    struct MAGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGMA>(arg0, 6, b"MAGMA", b"Magma Finance", b"Magma Finance is a decentralized, non-custodial liquidity protocol built on the Sui blockchain. The protocol introduces an AI-driven Adaptive Liquidity Market Maker (ALMM), designed to address the endemic challenges of capital inefficiency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1765819570275.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAGMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

