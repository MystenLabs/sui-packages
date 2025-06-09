module 0x588c17cbcce376fbfe69717bd7f1932f20fadf55a1fbc026c864fc78872f1f00::shegreen {
    struct SHEGREEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEGREEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEGREEN>(arg0, 9, b"she", b"shegreen", b"she is green", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/abef2907-4604-475a-a165-4a7629821606.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHEGREEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEGREEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

