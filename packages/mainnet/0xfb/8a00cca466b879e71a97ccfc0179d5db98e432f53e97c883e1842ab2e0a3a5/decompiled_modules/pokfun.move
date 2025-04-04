module 0xfb8a00cca466b879e71a97ccfc0179d5db98e432f53e97c883e1842ab2e0a3a5::pokfun {
    struct POKFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKFUN>(arg0, 9, b"POKFUN", b"POkefun", b"POKEFUN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/cce18ff86cd7b39a6c09e845d4282723blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POKFUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKFUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

