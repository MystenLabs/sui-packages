module 0xb2b4732f3884b193e28288e14f370265da382b2ec62efa59b968c7f0b79d9f7e::retartet {
    struct RETARTET has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETARTET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETARTET>(arg0, 6, b"RETARTET", b"chi the retartet baby", b"aaaamm reetartetttttttt.. leetz maeke historyy toogehterr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/989_aeb7c811e9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETARTET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RETARTET>>(v1);
    }

    // decompiled from Move bytecode v6
}

