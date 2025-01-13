module 0xa85fb271741081f4b026a45f830b62921b8ed9c44a6ca1f6f063af156dc8182f::awayx {
    struct AWAYX has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWAYX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWAYX>(arg0, 9, b"AWAYX", b"awx ", b"Meme token, mb pump :)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/47fbc605-1e8c-4fa5-a219-ff02000a2b0a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWAYX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AWAYX>>(v1);
    }

    // decompiled from Move bytecode v6
}

