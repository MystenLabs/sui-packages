module 0x719b8e4bb2d4bc4e373d1febb093529fb7660b7a18566693938b5c55eaf92ff3::slr {
    struct SLR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLR>(arg0, 9, b"SLR", b"STALKER ", b"S.T.A.L.K.E.R. is a series of video games developed and published by the Ukrainian company GSC Game World. Created in the genre of first-person shooter with elements of survival horror and role-playing game.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe9bcc71-93c0-4834-a180-b51ade5161c7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLR>>(v1);
    }

    // decompiled from Move bytecode v6
}

