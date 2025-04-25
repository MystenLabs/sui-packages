module 0x170035c6f61e81489237f3c11793c1a40c076843a4ab3dcbd390c0c3505a98a9::BOMB {
    struct BOMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOMB>(arg0, 6, b"BOMB", b"Bombardiro Crocodilo", b"Bombardiro CrocodiloBombardiro CrocodiloBombardiro CrocodiloBombardiro CrocodiloBombardiro CrocodiloBombardiro CrocodiloBombardiro CrocodiloBombardiro CrocodiloBombardiro Crocodilo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/Qmb9ZVrRnAzUYRofQ4L73H3rUUQiVAKUxZEMAWuF48R6Gr")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOMB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOMB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

