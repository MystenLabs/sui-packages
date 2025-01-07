module 0x19511d52ba07cd8bae57c3474414f37e658f6a22beedb3bcf20cca45ea54bf1c::edu {
    struct EDU has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDU>(arg0, 9, b"EDU", b"Chinedu", b"Personal name", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/391d4631-e00f-4ef4-b190-c8dd8992fac4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EDU>>(v1);
    }

    // decompiled from Move bytecode v6
}

