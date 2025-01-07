module 0x9f4fe1b34d570dc4eede6bde60405452d0ad3ff11e58d16bdc4f371b4f61e87d::gmc {
    struct GMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMC>(arg0, 9, b"GMC", b"Grumpy Cat", b"A famous meme cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/35832fa4-6aab-432b-937a-24a4db791316.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

