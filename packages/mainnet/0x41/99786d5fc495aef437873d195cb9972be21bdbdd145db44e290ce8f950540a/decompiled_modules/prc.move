module 0x4199786d5fc495aef437873d195cb9972be21bdbdd145db44e290ce8f950540a::prc {
    struct PRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRC>(arg0, 9, b"PRC", b"price", b"price meme one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cc9a8411-d1b3-4e34-8b38-2b876be0f4c7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRC>>(v1);
    }

    // decompiled from Move bytecode v6
}

