module 0x9678d5b64dee55848d2dd5c8e092da6a4ab73443e4847bde99ca4a4cad0d6d90::trial {
    struct TRIAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIAL>(arg0, 6, b"triAL", b"triAL and ErRor", b"All things can be fixed with a simple method  triAL and ErRor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tri_Al_62ed2b1f0f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRIAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

