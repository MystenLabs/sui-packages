module 0x3625f03d8125bfedbc66554456ceb59d27a8e1fe373d857abe542583d8bc186b::t147258369 {
    struct T147258369 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T147258369, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T147258369>(arg0, 9, b"T147258369", b"pig", b"This is the cutest pig", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ccd9729e-9e28-4e19-96c2-7422fa51e250.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T147258369>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T147258369>>(v1);
    }

    // decompiled from Move bytecode v6
}

