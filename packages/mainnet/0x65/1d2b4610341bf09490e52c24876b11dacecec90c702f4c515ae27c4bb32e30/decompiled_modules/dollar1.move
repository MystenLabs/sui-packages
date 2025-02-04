module 0x651d2b4610341bf09490e52c24876b11dacecec90c702f4c515ae27c4bb32e30::dollar1 {
    struct DOLLAR1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLLAR1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLLAR1>(arg0, 9, b"DOLLAR1", b"1$ to 1m$", b"1 dollar to a milly ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2eeab8228bd47737695210687be4ca8dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOLLAR1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLLAR1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

