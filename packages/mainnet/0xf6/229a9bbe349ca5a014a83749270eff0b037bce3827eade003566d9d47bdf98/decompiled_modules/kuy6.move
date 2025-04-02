module 0xf6229a9bbe349ca5a014a83749270eff0b037bce3827eade003566d9d47bdf98::kuy6 {
    struct KUY6 has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUY6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUY6>(arg0, 9, b"KUY6", b"kdyu", b"fyulkfylu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/099f9688a6854c7b21c667a10a683407blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KUY6>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUY6>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

