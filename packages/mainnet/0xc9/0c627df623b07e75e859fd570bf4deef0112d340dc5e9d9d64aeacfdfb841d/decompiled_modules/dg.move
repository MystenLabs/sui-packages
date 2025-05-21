module 0xc90c627df623b07e75e859fd570bf4deef0112d340dc5e9d9d64aeacfdfb841d::dg {
    struct DG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DG>(arg0, 9, b"DG", b"donkeykong", b"like you like", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6413eb3a1c8d66a46925e5f5eaa266e3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

