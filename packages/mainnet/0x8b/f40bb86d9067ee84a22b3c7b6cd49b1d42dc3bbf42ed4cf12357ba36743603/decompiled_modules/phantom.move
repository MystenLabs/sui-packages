module 0x8bf40bb86d9067ee84a22b3c7b6cd49b1d42dc3bbf42ed4cf12357ba36743603::phantom {
    struct PHANTOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHANTOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHANTOM>(arg0, 9, b"PHANTOM", b"PHANTOM WALLET", b"PHANTOM WALLET on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/be32ae633046487e166a4f90a9313a99blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PHANTOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHANTOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

