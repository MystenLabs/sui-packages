module 0x273a141d1bdf75d245c25afcc31e908cbeddecb97d3209a17e58f6b17da8027a::som {
    struct SOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOM>(arg0, 9, b"SOM", b"Somnia", x"536f6d6e6961207820535549200a70726520746f6b656e73206265666f7265205447452e204c657473206275696c6420746f676574686572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5fd8ea35f1989b908359428be0cfc25eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

