module 0xb8f7930836551e364bec22cc905da385e617536bc96ba785111c62375ad56ebf::usdg {
    struct USDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDG>(arg0, 9, b"USDG", b"USDGold ", b"USDGold (USDG) is a meme coin blending the charm of gold with the fun of crypto. Join the USDG movement and add some sparkle to your digital wallet!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c4952ef9-a7af-4e27-aea2-46d7ea722f15.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

