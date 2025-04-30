module 0xcb78ad02d31786a0e4c9d9af75be037a71a2e2fb112e5a132b889ae3d2df41f2::gods {
    struct GODS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODS>(arg0, 9, b"GODS", b"GODSUI", b"GodSui, WE ALL EAT!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7c04e30003697d60782c9e948accf36bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GODS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

