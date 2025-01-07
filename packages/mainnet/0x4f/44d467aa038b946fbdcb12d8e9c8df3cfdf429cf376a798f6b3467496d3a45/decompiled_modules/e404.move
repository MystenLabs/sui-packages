module 0x4f44d467aa038b946fbdcb12d8e9c8df3cfdf429cf376a798f6b3467496d3a45::e404 {
    struct E404 has drop {
        dummy_field: bool,
    }

    fun init(arg0: E404, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<E404>(arg0, 9, b"E404", b"Error404", b"Error 404", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/25f55a84-c175-4922-859d-5d4839d3d742.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<E404>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<E404>>(v1);
    }

    // decompiled from Move bytecode v6
}

