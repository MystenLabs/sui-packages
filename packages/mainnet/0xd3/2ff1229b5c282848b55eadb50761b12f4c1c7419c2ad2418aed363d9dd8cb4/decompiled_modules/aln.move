module 0xd32ff1229b5c282848b55eadb50761b12f4c1c7419c2ad2418aed363d9dd8cb4::aln {
    struct ALN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALN>(arg0, 9, b"ALN", b"Alien", b"this fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/bbf846885e27982688d5f6acd03ca02eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

