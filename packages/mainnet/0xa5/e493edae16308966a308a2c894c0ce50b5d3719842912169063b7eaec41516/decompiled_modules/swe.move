module 0xa5e493edae16308966a308a2c894c0ce50b5d3719842912169063b7eaec41516::swe {
    struct SWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWE>(arg0, 9, b"SWE", b"Suiwaveme", b"This is a meme for all Suiers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/04c80bb6-cfc1-42f3-be8f-464badca8c0a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

