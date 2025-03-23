module 0x1060b2f50c9a95dc028ed52c122a5cc24d7a49aaf738ac555a377336580b69b6::wanted {
    struct WANTED has drop {
        dummy_field: bool,
    }

    fun init(arg0: WANTED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WANTED>(arg0, 9, b"Wanted", b"Criminal", b"wanted criminals interpol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/10f4c4dd62418e647457953841aec4adblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WANTED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WANTED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

