module 0xafb46b31ec764c65fb13b7a95420741fa970b5f7b0edac851d6d680dea0ec8f2::mib {
    struct MIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIB>(arg0, 9, b"MIB", b"Mibera", b"Mibera ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b79a595707cea61104b7082d4e132b0eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

