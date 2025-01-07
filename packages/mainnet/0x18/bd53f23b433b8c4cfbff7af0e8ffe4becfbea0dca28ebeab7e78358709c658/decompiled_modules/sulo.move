module 0x18bd53f23b433b8c4cfbff7af0e8ffe4becfbea0dca28ebeab7e78358709c658::sulo {
    struct SULO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SULO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SULO>(arg0, 9, b"SULO", b"Sunlong", b"The sibling meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a25909d2-0322-4cfb-bf1f-9f6d44613560.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SULO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SULO>>(v1);
    }

    // decompiled from Move bytecode v6
}

