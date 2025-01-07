module 0xcf5c7d73a26a1db2b2f0546f7bd945ba17a86810fdc7277beaa8d24d7fa632e0::bullmarket {
    struct BULLMARKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLMARKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLMARKET>(arg0, 9, b"BULLMARKET", b"BMT", b"BULLMARKET is the only coin to lead the bullrun even in bear season.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/34cb5891-0400-4508-9692-edeaaf9e53f1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLMARKET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULLMARKET>>(v1);
    }

    // decompiled from Move bytecode v6
}

