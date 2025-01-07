module 0x60e932d44327baf07a7a73d02ae948c37edc911a5e90a09ec7e9c7b1379002ea::sponge {
    struct SPONGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPONGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPONGE>(arg0, 9, b"SPONGE", b"SPONGE on Sui", x"2453504f4e4745207c204a75737420616e6f7468657220676f6f6420646179206f6e200a405375694e6574776f726b0a204f6365616e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6377a93d41b4808acf5ad40d4460be22blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPONGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPONGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

