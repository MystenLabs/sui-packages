module 0xef940dcfb142da82da473838b689e610445f609a09e89522f1c188c3d8f01c30::lalejru {
    struct LALEJRU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LALEJRU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LALEJRU>(arg0, 9, b"Lalejru", b"lala", b"csgvsdg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f2651d6a437d66979ba779da8f99672eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LALEJRU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LALEJRU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

