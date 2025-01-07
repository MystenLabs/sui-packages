module 0x3af88e995989e31b702946380a8bcdeb8c809cf2e697dd6e167e1a5f943db7f7::sure {
    struct SURE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURE>(arg0, 9, b"SURE", b"sureable", b"this token is used to transaction in  metaverse AI world,in project beta we have a plan to realized a token can used for bought in metaverse", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2044b5cc-21a0-416b-8bb9-7d58042d277a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SURE>>(v1);
    }

    // decompiled from Move bytecode v6
}

