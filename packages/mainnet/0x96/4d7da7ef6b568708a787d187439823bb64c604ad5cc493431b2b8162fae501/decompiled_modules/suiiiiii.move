module 0x964d7da7ef6b568708a787d187439823bb64c604ad5cc493431b2b8162fae501::suiiiiii {
    struct SUIIIIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIIIIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIIIIII>(arg0, 9, b"SUIIIIII", b"AnthonySui", b"The goat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/520ff1f6-bf23-4ddf-a263-ee567490e578.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIIIIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIIIIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

