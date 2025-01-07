module 0xfbd68a52e9e2ebef8d16e1a2fa6ece0f9006104cf458cd3093b5bb7d36c25545::cha {
    struct CHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHA>(arg0, 9, b"CHA", b"chacho", b"chacho no voy borracho voy colocao", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9e17488e810e419a9714e6cb767f86d8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

