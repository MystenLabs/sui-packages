module 0x6bb5417c77ec33ab2f27095cc864dba91a639395a710f82c78ce9e4f1acaed1e::noargo {
    struct NOARGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOARGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOARGO>(arg0, 9, b"NOARGO", b"Disconnected", b"Argentina disconnected from the Mianland", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6b82d506f7baaf1b2c0572b37cb3b82dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOARGO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOARGO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

