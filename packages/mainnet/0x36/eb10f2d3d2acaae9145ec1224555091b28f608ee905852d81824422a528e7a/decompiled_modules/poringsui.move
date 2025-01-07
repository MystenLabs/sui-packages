module 0x36eb10f2d3d2acaae9145ec1224555091b28f608ee905852d81824422a528e7a::poringsui {
    struct PORINGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORINGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORINGSUI>(arg0, 9, b"PORINGSUI", b"PORING", b"$PORING The true meme token on $SUI blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4eaa67ad-9fb0-4f4d-8456-bf082bb60a2a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORINGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PORINGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

