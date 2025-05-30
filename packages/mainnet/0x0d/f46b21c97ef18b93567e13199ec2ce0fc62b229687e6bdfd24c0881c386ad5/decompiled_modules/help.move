module 0xdf46b21c97ef18b93567e13199ec2ce0fc62b229687e6bdfd24c0881c386ad5::help {
    struct HELP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELP>(arg0, 9, b"HELP", b"Please Read", x"48692c2049206163636964656e74616c6c792073656e7420796f7520736f6d652053554920616e642041495355492e20436f756c6420796f7520706c656173652073656e64206974206261636b3f2049e2809964207265616c6c7920617070726563696174652069742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/85edaad74cf655c690ad8e6491028544blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

