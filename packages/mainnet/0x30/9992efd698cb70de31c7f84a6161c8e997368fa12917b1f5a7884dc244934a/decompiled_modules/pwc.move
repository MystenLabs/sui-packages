module 0x309992efd698cb70de31c7f84a6161c8e997368fa12917b1f5a7884dc244934a::pwc {
    struct PWC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWC>(arg0, 9, b"PWC", b"P Walrus", b"Potato Walrus Coin is a novel cryptocurrency with a quirky twist that supports wildlife conservation! Inspired by the viral sketch of a walrus that looks remarkably like a potato.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/874291fc-f77e-4d32-99e9-125bcef3da30.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PWC>>(v1);
    }

    // decompiled from Move bytecode v6
}

