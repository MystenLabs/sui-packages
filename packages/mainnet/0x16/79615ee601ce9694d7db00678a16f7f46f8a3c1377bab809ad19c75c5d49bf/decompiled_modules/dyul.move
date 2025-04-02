module 0x1679615ee601ce9694d7db00678a16f7f46f8a3c1377bab809ad19c75c5d49bf::dyul {
    struct DYUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DYUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DYUL>(arg0, 9, b"DYUL", b"ysdfyu", b"fydlu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1a003c2db80709aa6c553ff01f2f46c7blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DYUL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DYUL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

