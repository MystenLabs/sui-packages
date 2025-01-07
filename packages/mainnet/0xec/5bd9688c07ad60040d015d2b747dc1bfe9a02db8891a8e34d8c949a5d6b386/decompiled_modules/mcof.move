module 0xec5bd9688c07ad60040d015d2b747dc1bfe9a02db8891a8e34d8c949a5d6b386::mcof {
    struct MCOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCOF>(arg0, 9, b"MCOF", b"Morning Coffee", b"Good Morning Coffee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/37daffc47851ea19b5e27a1b7c0c0b2cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCOF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCOF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

