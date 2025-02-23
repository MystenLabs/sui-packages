module 0x8dbdb247352944f3ed708c48dc0891e52651547fdd36911b60f552d0c8364cae::milkkkkk {
    struct MILKKKKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILKKKKK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILKKKKK>(arg0, 9, b"Milkkkkk", b"MMMilk Sui", b"milk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4e1594f1e3f31598ca6d0f1ce21a0882blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MILKKKKK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILKKKKK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

