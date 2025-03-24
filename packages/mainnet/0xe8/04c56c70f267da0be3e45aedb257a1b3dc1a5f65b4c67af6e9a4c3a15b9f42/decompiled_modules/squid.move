module 0xe804c56c70f267da0be3e45aedb257a1b3dc1a5f65b4c67af6e9a4c3a15b9f42::squid {
    struct SQUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUID>(arg0, 9, b"SQUID", b"SQUID ON SUI", b"First Meme of Squid on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/628963734eddf12f1308a475a2e3130bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQUID>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUID>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

