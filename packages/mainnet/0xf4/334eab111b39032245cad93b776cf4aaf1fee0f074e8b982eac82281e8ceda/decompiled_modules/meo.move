module 0xf4334eab111b39032245cad93b776cf4aaf1fee0f074e8b982eac82281e8ceda::meo {
    struct MEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEO>(arg0, 9, b"MEO", b"MEOWW", b"MEOEOOOEE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/5644b5077bc6fbcc8f1532b49b5bc887blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

