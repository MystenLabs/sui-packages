module 0xf249c49de48c47835a89f162a511f624cc143ee21a7202cf1eb1d0795f236d94::keba {
    struct KEBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEBA>(arg0, 6, b"KEBA", b"KebanK", b"KebanK  is AI blockchain-based platform designed to operate within the Sui ecosystem. The project focuses on creating a robust and scalable decentralized finance (DeFi) and DeFAI solution that supports seamless token swaps, liquidity provision, and ecosystem growth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ivan_Airoldi_kebank_ai_defi_f1b309e1_3386_42d3_be7f_841daf38a660_39fcdfc43c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

