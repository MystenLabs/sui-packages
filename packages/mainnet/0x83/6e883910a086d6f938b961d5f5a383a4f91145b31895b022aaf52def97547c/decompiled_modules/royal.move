module 0x836e883910a086d6f938b961d5f5a383a4f91145b31895b022aaf52def97547c::royal {
    struct ROYAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROYAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROYAL>(arg0, 9, b"ROYAL", b"KING", b"KING is a meme inspired by the spirit of glory and power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa886a36-7e66-4ef6-934f-e1ca88369601.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROYAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROYAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

