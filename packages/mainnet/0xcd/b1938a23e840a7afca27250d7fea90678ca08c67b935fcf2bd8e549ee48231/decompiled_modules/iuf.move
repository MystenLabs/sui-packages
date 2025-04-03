module 0xcdb1938a23e840a7afca27250d7fea90678ca08c67b935fcf2bd8e549ee48231::iuf {
    struct IUF has drop {
        dummy_field: bool,
    }

    fun init(arg0: IUF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IUF>(arg0, 9, b"IUF", b"liul", b"fyhliu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ea2e2ac67a94db3f6fcf7b5da0e2bfd4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IUF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IUF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

