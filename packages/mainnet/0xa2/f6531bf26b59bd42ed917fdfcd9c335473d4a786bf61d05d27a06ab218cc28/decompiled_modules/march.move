module 0xa2f6531bf26b59bd42ed917fdfcd9c335473d4a786bf61d05d27a06ab218cc28::march {
    struct MARCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARCH>(arg0, 9, b"MARCH", b"MarchicaCrypto", b"in memory of the X user @MarchicaCrypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c7d6d3298d489cf27595d7e79df4be34blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARCH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

