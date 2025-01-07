module 0x750d79879d92ba99f2e1665ce2a7f6a97334a795806b3b741c790a05b0e4ccc1::suiape {
    struct SUIAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAPE>(arg0, 9, b"Suiape", b"Sui Apes ", b"Degen Ape on the block...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/fc8ccadce99481413e5dbe050dbca336blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIAPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

