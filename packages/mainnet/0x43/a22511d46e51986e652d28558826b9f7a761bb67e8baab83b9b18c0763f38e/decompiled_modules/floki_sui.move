module 0x43a22511d46e51986e652d28558826b9f7a761bb67e8baab83b9b18c0763f38e::floki_sui {
    struct FLOKI_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOKI_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOKI_SUI>(arg0, 9, b"Floki_sui", b"Floki on sui", b"just a meme of floki on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b34766e22e1e314afa153eb8ab160258blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLOKI_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOKI_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

