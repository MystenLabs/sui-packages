module 0x58268349e75804828bb33ccf90f3f8afd6a2e8e5061752843f41421578fa84e5::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 6, b"E2ET", b"E2E Test Token", b"A token deployed via E2E test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

