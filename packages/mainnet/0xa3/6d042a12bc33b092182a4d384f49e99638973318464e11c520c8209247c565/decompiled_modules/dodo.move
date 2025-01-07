module 0xa36d042a12bc33b092182a4d384f49e99638973318464e11c520c8209247c565::dodo {
    struct DODO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DODO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DODO>(arg0, 9, b"DODO", b"Dodo", b"DODO is a DeFi protocoldecentralized finance (DeFi) protocol and on-chain liquidity provider whose unique proactive market maker (PMM) algorithm aims to offer better liquidity and price stability than automated market makers (AMM).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/02114b8b-6b68-4392-8ed0-07dbd2f3ddbe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DODO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DODO>>(v1);
    }

    // decompiled from Move bytecode v6
}

