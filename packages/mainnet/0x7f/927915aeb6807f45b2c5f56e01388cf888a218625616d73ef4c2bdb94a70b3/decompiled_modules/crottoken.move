module 0x7f927915aeb6807f45b2c5f56e01388cf888a218625616d73ef4c2bdb94a70b3::crottoken {
    struct CROTTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROTTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROTTOKEN>(arg0, 9, b"CROTTOKEN", b"Crot", b"Crot meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/272122cc-a995-4c28-8b01-395bfb80fe75.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROTTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CROTTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

