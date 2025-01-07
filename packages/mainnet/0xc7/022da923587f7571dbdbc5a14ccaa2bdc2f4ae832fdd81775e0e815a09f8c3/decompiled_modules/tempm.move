module 0xc7022da923587f7571dbdbc5a14ccaa2bdc2f4ae832fdd81775e0e815a09f8c3::tempm {
    struct TEMPM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMPM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEMPM>(arg0, 9, b"TEMPM", b"TESTTMORE", b"aaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/615e82c79727c24c68f2874c9228d2d0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEMPM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEMPM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

