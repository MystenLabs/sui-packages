module 0x8fa4f60ff4e42177e958ed1e01c62f2e298b0b9e82e379bc454d4f7b5aa367a8::witc {
    struct WITC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WITC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WITC>(arg0, 6, b"WITC", b"Witc Crock", b"Welcome to WITC CROCK ($WITC)where the magic of memes meets the lucky Witch Crock of the Sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000067918_4165b1629b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WITC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WITC>>(v1);
    }

    // decompiled from Move bytecode v6
}

