module 0x4305485ff54fecd0842d34d4d60c6f4df0686a5d3de36d8d660f7de0f3eed309::mro {
    struct MRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRO>(arg0, 9, b"Mro", b"Roma", b"44", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/86c88a212b209d27482f5e781765a4f4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

