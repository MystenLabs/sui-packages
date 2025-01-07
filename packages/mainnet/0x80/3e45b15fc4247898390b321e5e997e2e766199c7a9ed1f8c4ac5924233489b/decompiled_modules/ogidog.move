module 0x803e45b15fc4247898390b321e5e997e2e766199c7a9ed1f8c4ac5924233489b::ogidog {
    struct OGIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGIDOG>(arg0, 9, b"OGIDOG", b"Ogi", b"An authentic meme coin derived from the animation Ogi With a reliable and strong community, the possibility of it multiplying, buy it at a low price, don't stay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/59a92475-910a-4b9a-943e-a1468c8e7e8c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OGIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

