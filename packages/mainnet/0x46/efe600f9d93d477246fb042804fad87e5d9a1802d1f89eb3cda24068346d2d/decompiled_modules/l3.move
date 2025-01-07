module 0x46efe600f9d93d477246fb042804fad87e5d9a1802d1f89eb3cda24068346d2d::l3 {
    struct L3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: L3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<L3>(arg0, 9, b"L3", b"LOCK3000", x"4c4f434b20333030300a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/6c82ef9216337585fe5b677f7de32057blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<L3>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<L3>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

