module 0x4ab0c69a590414d14902793038450a73a56f75ee864bc15f26fe009380757974::dertwb {
    struct DERTWB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DERTWB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DERTWB>(arg0, 9, b"DERTWB", b"Dert", b"NEW MEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/cdb09193c4d565896d7e9b96f81df6c1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DERTWB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DERTWB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

