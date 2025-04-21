module 0xbdbc3ea0d24375934b6cde334410827888114575c2a1a5e8d10f575be5cdc3d6::via {
    struct VIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIA>(arg0, 9, b"VIA", b"italy", b"pizza, fiat and spaghetti ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a2801df843b50b937a048a7c09ae8700blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VIA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

