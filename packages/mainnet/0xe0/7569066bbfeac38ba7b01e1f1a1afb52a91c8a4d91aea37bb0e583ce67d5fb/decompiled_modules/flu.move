module 0xe07569066bbfeac38ba7b01e1f1a1afb52a91c8a4d91aea37bb0e583ce67d5fb::flu {
    struct FLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLU>(arg0, 9, b"FLU", b"FLUMINENSE", b"Fluminense Football Club", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3db8001927ca16d11a081c8d5249ce71blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

