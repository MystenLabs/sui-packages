module 0x28c360dcf97fba1fbc83b41413dcf5012cdce421d9aa67e06657a56a775c36b6::bony {
    struct BONY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONY>(arg0, 6, b"BONY", b"Sui bony", b"BONY is no ordinary dog, cute but strong, intelligent and persistent, he roams the vast plains with noble goals", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008686_b690978451.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONY>>(v1);
    }

    // decompiled from Move bytecode v6
}

