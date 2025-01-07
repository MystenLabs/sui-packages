module 0xc70d0742cb650b059ac2df7becef452ec229a2576b2af39b2c9bba0456138d69::wormy {
    struct WORMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORMY>(arg0, 9, b"WORMY", b"Wormy", b"Wormy is a memecoin inspired by the animated series SpongeBob Squarepants in the episode that tells of chaos in Bikini Bottom due to insects that transform into butterflies roaming the city.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0d4a9659-6eb1-49a7-8dff-1971d8bde2ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WORMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

