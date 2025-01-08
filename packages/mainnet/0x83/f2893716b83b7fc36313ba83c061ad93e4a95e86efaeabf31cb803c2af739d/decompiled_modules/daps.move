module 0x83f2893716b83b7fc36313ba83c061ad93e4a95e86efaeabf31cb803c2af739d::daps {
    struct DAPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAPS>(arg0, 9, b"DAPS", b"SUI DAOS", b"daos.sui shapes a new era of investing in AI, DeSci, and meme coins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f606b7d9fb3795e8f25bee44167b340dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAPS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAPS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

