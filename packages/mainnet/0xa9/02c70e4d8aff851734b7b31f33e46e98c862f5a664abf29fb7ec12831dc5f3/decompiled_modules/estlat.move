module 0xa902c70e4d8aff851734b7b31f33e46e98c862f5a664abf29fb7ec12831dc5f3::estlat {
    struct ESTLAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESTLAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESTLAT>(arg0, 9, b"ESTLAT", b"EstlatCoin", b"First coin of Esther ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/de9fb26c-a5ef-408f-8344-f9e4af5d0055.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESTLAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ESTLAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

