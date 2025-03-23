module 0x257c06574a97c8e330f3929836a91640c386e2d6f76a6c512cf912ce7978c0cf::migt {
    struct MIGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIGT>(arg0, 6, b"MIGT", b"MIGRANTC", b"Migrating is a right of every living being, A typical Arctic tern will travel a distance equivalent to that of the moon and back in its lifetime.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1742762484749.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIGT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIGT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

