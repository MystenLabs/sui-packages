module 0x64b6dc09329fc79c49143ffa1b023393641af1a45755cce79e9080aac9a20f48::nit {
    struct NIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIT>(arg0, 9, b"NIT", b"Nitlul ", b"Nitkull", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be-alpha.7k.fun/api/file-upload/b129969b9ed0b54b9d649cd7a846f4acblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

