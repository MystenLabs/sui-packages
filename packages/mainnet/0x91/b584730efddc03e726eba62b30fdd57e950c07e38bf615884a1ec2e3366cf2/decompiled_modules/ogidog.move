module 0x91b584730efddc03e726eba62b30fdd57e950c07e38bf615884a1ec2e3366cf2::ogidog {
    struct OGIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGIDOG>(arg0, 9, b"OGIDOG", b"Ogi", b"An authentic meme coin derived from the animation Ogi With a reliable and strong community, the possibility of it multiplying, buy it at a low price, don't stay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2869d746-b727-4463-a583-5b0a532de671.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OGIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

