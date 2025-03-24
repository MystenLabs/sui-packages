module 0x24bf91047bcb9f2bde86db974215481ecfaf878541ebb0ee7bea1235d35db030::bala {
    struct BALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALA>(arg0, 9, b"BALA", b"BALANCE", x"546f6b656e20737461727465642032342e30332e323032360a0a20202020202020202020202020202020202020202020204f6666696369616c20666972737420736561736f6e2020202042414c41c2a9efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/388dd5bc61044967f43940f273fef7c0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BALA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

