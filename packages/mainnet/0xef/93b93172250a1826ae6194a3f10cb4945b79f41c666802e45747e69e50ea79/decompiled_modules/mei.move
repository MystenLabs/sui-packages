module 0xef93b93172250a1826ae6194a3f10cb4945b79f41c666802e45747e69e50ea79::mei {
    struct MEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEI>(arg0, 9, b"Mei", b"Meo", b"Neoo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/59fb184de5e2ef5b4f30879a12bef047blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

