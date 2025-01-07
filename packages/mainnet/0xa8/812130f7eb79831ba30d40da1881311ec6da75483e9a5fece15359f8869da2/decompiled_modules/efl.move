module 0xa8812130f7eb79831ba30d40da1881311ec6da75483e9a5fece15359f8869da2::efl {
    struct EFL has drop {
        dummy_field: bool,
    }

    fun init(arg0: EFL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EFL>(arg0, 9, b"EFL", b"Eiffel", b"Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/7056a4902a52bf75badafed0201d3657blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EFL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EFL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

