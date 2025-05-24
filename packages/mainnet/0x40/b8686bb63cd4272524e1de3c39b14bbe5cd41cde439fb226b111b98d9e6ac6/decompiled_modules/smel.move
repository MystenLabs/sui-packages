module 0x40b8686bb63cd4272524e1de3c39b14bbe5cd41cde439fb226b111b98d9e6ac6::smel {
    struct SMEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMEL>(arg0, 9, b"SMEL", b"SUI MEL", b"enak tur empuk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/68276117d0fa3b39d9dfbe69c76a0c37blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMEL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMEL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

