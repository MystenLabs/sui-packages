module 0x9cd9e3b6952668f5e6da5b4778df0aa5e9ce8f473fbfaba2e18a3b3ad139add9::bene {
    struct BENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENE>(arg0, 9, b"BENE", b"Benebuchi", b"Walking to earn with good slippers meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e6223fd2-0169-4331-b67c-80795ebff222.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BENE>>(v1);
    }

    // decompiled from Move bytecode v6
}

