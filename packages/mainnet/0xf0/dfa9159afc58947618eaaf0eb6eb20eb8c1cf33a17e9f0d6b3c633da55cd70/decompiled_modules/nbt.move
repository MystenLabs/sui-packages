module 0xf0dfa9159afc58947618eaaf0eb6eb20eb8c1cf33a17e9f0d6b3c633da55cd70::nbt {
    struct NBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NBT>(arg0, 9, b"NBT", b"nobita", b"go to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/886bfec4576657420b785c10c33cf3c2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NBT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NBT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

