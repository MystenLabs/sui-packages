module 0x2857e052fa18d00dd4662128b46a98b029b9e29f3c81b002be5e65f86b6d4989::dur {
    struct DUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUR>(arg0, 9, b"DUR", b"DARISUI", b"money A piece of currency, usually metallic and in the shape of a disc, but sometimes polygonal, or with a hole in the middle.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3eb1370aac84b74dc0003aa7bb510f9ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

