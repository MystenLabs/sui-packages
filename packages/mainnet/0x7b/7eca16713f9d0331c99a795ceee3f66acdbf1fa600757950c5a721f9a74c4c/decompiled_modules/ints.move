module 0x7b7eca16713f9d0331c99a795ceee3f66acdbf1fa600757950c5a721f9a74c4c::ints {
    struct INTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: INTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INTS>(arg0, 9, b"INTS", b"Interstella", b"1000000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/93ef0790dffd91b9ff8c282389e9e0c4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

