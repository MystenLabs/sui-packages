module 0x710139ce3bd82616da6ba6930d0259ccf3f744724badf5b916524921a261d497::fs {
    struct FS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FS>(arg0, 6, b"FS", b"Funkii Studio", b"Brand kits, sold to agents.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://t2000.ai/icon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<FS>>(0x2::coin::mint<FS>(&mut v2, 1000000000000000, arg1), @0x7f2059fb1c395f4800809b4b97ed8e661535c8c55f89b1379b6b9d0208d2f6dc);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FS>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FS>>(v2);
    }

    // decompiled from Move bytecode v7
}

