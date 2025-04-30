module 0x94664716cd3bfa3bd65fc2293f6cc016203edcb955c61ed28513ef612ac88b6b::ktxx {
    struct KTXX has drop {
        dummy_field: bool,
    }

    fun init(arg0: KTXX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KTXX>(arg0, 9, b"KTXX", b"Kouthexx", b"ktx7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8f63778cfa926d65e876694cb57924bdblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KTXX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KTXX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

