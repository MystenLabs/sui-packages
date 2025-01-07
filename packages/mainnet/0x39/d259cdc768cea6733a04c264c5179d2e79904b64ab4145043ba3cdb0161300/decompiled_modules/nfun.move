module 0x39d259cdc768cea6733a04c264c5179d2e79904b64ab4145043ba3cdb0161300::nfun {
    struct NFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NFUN>(arg0, 9, b"NFUN", b"NOTFUN", b"Coin just for fun, enjoy in sui ecosystem and ready for sui new ATH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6e20de60-2ccb-4ad5-b296-1a230f821ed8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

