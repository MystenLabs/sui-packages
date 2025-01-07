module 0x24ed8aa0fb397b7a8b18bc1760f03387e09311172503773c476457d2c1de4606::redsmb {
    struct REDSMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: REDSMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REDSMB>(arg0, 9, b"REDSMB", b"Reditus", b"Token for Bitcoin mining. 1000 tokens corresponds to a power of 1 Th/s.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/56a33205-3e7f-4750-b02c-22ae75311f10.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REDSMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REDSMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

