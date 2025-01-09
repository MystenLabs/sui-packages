module 0xfdce13481262bb9b7f479cc08e6b4435ebfabb49edd705100d67730365a43f12::retard {
    struct RETARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETARD>(arg0, 9, b"retrd", b"retard nigga butt", b"retard motherfucker gunna retard", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.top100token.com/images/62e0e85e-b9d6-4363-8af0-4ad751af3ebb.webp")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<RETARD>>(0x2::coin::mint<RETARD>(&mut v2, 998668574000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RETARD>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RETARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

