module 0x53ca4a49dadf1fd4815b31817be83a235a6e830aed53771c9bf46261db8bd7dc::medi {
    struct MEDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEDI>(arg0, 9, b"MEDI", b"Medical.ind", b"Bringing all new innovation of medical field into crypto and awareness of financial importance ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c0a9ca2223fce727abeb3f0f705ef083blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEDI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEDI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

