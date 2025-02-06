module 0x462adba34360c745f9926382bc367c85f375e3edfdd69f96ee28da253c4c8473::arm {
    struct ARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARM>(arg0, 9, b"ARM", b"ARM coin", b"Armenian economic ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c16d4639aa966d94770035a79e4c9216blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

