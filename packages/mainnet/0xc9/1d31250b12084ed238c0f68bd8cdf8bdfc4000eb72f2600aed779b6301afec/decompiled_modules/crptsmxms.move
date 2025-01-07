module 0xc91d31250b12084ed238c0f68bd8cdf8bdfc4000eb72f2600aed779b6301afec::crptsmxms {
    struct CRPTSMXMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRPTSMXMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRPTSMXMS>(arg0, 9, b"CRPTSMXMS", b"CRYPTUSmax", b"Crypto-trading community token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f51f26ba-7289-415b-8b68-8405802a75ef-imgonline-com-ua-Resize-iMuLqWkGHv7Riv.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRPTSMXMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRPTSMXMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

