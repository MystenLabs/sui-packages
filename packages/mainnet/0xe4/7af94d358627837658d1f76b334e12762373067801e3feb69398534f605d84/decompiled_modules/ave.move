module 0xe47af94d358627837658d1f76b334e12762373067801e3feb69398534f605d84::ave {
    struct AVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVE>(arg0, 9, b"AVE", b"Avemes", x"4e756576612067656e6572616369c3b36e20646520636f6d756e6963616369c3b36e20617665206d656d657320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ab3159c5-b92f-4eb6-9c0b-d622c620e313.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

