module 0x5357a694e33f33b6ab2bdd17bc33ff73643bbbdea6a0600a4bc725a02e511881::osimen {
    struct OSIMEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSIMEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSIMEN>(arg0, 9, b"Osimen", b"Osimenmen", b"Good project gooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/148f6606732754ba3c5160b937f3e93ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSIMEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSIMEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

