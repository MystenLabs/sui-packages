module 0x77a021a55fab4ad1dea5f3bafa7aba47cee8f4d0d4a9852d520cfc49fe09df65::nme {
    struct NME has drop {
        dummy_field: bool,
    }

    fun init(arg0: NME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NME>(arg0, 9, b"NME", b"Nam Meme ", b"A2 team with love", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/379ea61c-b9aa-4845-8a9b-c612ee72f3eb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NME>>(v1);
    }

    // decompiled from Move bytecode v6
}

