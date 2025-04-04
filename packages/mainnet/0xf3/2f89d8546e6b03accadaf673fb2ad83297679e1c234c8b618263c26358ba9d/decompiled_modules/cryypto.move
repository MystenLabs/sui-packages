module 0xf32f89d8546e6b03accadaf673fb2ad83297679e1c234c8b618263c26358ba9d::cryypto {
    struct CRYYPTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYYPTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYYPTO>(arg0, 9, b"CRYYPTO", b"cryp", b"NEW MEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9b52b5c57e37c2a541bebb3be7df45b6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRYYPTO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYYPTO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

