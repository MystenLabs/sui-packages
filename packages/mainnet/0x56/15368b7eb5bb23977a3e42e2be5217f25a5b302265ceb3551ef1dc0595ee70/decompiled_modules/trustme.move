module 0x5615368b7eb5bb23977a3e42e2be5217f25a5b302265ceb3551ef1dc0595ee70::trustme {
    struct TRUSTME has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUSTME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUSTME>(arg0, 9, b"TRUSTME", b"TRUST", b"aaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/2f66d14a2db6be680e474001a88b2489blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUSTME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUSTME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

