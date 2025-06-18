module 0x3491696b3b4322f966b8ff3efbb6ae29125039fa91c8bbcd150cedf13ff07012::akb {
    struct AKB has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKB>(arg0, 9, b"AKB", b"Akblaed", b"jalim", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ce69f3866d45f6032576a9f2f2c83e0eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AKB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

