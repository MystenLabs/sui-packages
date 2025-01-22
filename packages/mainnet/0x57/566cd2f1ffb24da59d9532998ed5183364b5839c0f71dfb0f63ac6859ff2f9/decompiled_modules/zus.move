module 0x57566cd2f1ffb24da59d9532998ed5183364b5839c0f71dfb0f63ac6859ff2f9::zus {
    struct ZUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUS>(arg0, 4, b"ZUS", b"Zustand", b"Test token Dao", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/0206c5e0-d8a0-11ef-8165-f761f2caed44")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZUS>>(v1);
        0x2::coin::mint_and_transfer<ZUS>(&mut v2, 11000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

