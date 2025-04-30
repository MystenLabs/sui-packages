module 0xd6dba3bfd8c9f88bef5fdc638b59b79fe347822a94e2d7150eed28067946c786::gods {
    struct GODS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODS>(arg0, 9, b"GODS", b"GodSui", b"Godsui, WE ALL EAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/59870d6a2746cffbc251e53975a9540eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GODS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

