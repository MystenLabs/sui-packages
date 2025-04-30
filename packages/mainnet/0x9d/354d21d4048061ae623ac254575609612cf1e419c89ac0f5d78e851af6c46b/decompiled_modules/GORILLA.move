module 0x9d354d21d4048061ae623ac254575609612cf1e419c89ac0f5d78e851af6c46b::GORILLA {
    struct GORILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GORILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GORILLA>(arg0, 6, b"GORILLA", b"Gorilla", b"1 gorilla or 100 man?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmbFyrVCeHHt3qUwhSre3bmhvDX7F3nExah2XFhxw8sGpJ")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GORILLA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GORILLA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

