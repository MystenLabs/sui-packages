module 0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana {
    struct FAUCET_PROCARIHANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAUCET_PROCARIHANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET_PROCARIHANA>(arg0, 8, b"FAUCET_PROCARIHANA", b"FAUCET_PROCARIHANA", b"FOR FAUCET_PROCARIHANA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sns-webpic-qc.xhscdn.com/202503032301/ab6dddfbf1bb6e8d92a9542cab6b7850/1040g00830s621dibis005n0rmhmhhlslolfkbd0!nd_dft_wlteh_webp_3")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET_PROCARIHANA>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCET_PROCARIHANA>>(v0);
    }

    public entry fun mint_coin(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_PROCARIHANA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FAUCET_PROCARIHANA>>(0x2::coin::mint<FAUCET_PROCARIHANA>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

