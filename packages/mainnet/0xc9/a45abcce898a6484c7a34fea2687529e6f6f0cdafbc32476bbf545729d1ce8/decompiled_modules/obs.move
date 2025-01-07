module 0xc9a45abcce898a6484c7a34fea2687529e6f6f0cdafbc32476bbf545729d1ce8::obs {
    struct OBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OBS>(arg0, 9, b"OBS", b"OBUS", b"I'm creating this meme for my birthday. Wish me well by buying my memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/efb243c4-bc5f-4ad2-b652-b28b37a638c9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

