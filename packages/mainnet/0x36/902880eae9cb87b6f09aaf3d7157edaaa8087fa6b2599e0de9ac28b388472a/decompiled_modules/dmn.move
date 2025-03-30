module 0x36902880eae9cb87b6f09aaf3d7157edaaa8087fa6b2599e0de9ac28b388472a::dmn {
    struct DMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMN>(arg0, 9, b"Dmn", b"domnia", b"new coin on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2f1be0eab8f5db19e871b5be617685f1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DMN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

