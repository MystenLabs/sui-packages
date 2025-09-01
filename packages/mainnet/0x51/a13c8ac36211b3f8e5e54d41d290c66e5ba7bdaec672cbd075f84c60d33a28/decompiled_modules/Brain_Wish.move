module 0x51a13c8ac36211b3f8e5e54d41d290c66e5ba7bdaec672cbd075f84c60d33a28::Brain_Wish {
    struct BRAIN_WISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAIN_WISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAIN_WISH>(arg0, 9, b"BRISH", b"Brain Wish", b"wish i had a brain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzxgEt2bUAAsaEW?format=jpg&name=900x900")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRAIN_WISH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAIN_WISH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

