module 0x5cbd6cf8bed30a092ede7dcfef5e8732dda782df06bbcbe00cbdd4d61aa66cba::suinea {
    struct SUINEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINEA>(arg0, 9, b"Suinea", b"GuineaPig on Sui", b"That Token is for all guinea pig lovers on Sui Chain.  It has no value at all, it is just a fun token. Keep it cheap, so everyone who like guinea pigs may obtain some. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/55f909a6af096238a03da87f407636d4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINEA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINEA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

