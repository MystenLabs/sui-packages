module 0x7aa26dda546e0d9b7037d9328add9b6f35d969d050961e17658c951c00191b09::scarrot {
    struct SCARROT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCARROT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCARROT>(arg0, 9, b"SCARROT", b"ScarrotF", b"Meme for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed342cd7-91d1-49b6-a698-76dc57f24a7e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCARROT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCARROT>>(v1);
    }

    // decompiled from Move bytecode v6
}

