module 0xe6db8a7b96feb1ec24dcdf397f8423b224dcb6f2dbedc7ba0f03965f5b5424a4::mir {
    struct MIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIR>(arg0, 9, b"MIR", b"Mirro", b"Mirro in Blue Bangkok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/18c3255e6b3fd0d98e21087d275dde65blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

