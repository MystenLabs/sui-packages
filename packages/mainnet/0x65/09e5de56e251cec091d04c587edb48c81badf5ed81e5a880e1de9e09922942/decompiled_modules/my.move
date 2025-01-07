module 0x6509e5de56e251cec091d04c587edb48c81badf5ed81e5a880e1de9e09922942::my {
    struct MY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY>(arg0, 9, b"MY", b"Miss you", b"Miss you so much", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/705283f9-3ec1-4441-b493-b26433cfca71.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY>>(v1);
    }

    // decompiled from Move bytecode v6
}

