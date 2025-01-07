module 0x4f3904fa0c024067da320dafcb42f34bdfb69870e91c4720525afb7b95db8272::db {
    struct DB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DB>(arg0, 6, b"DB", b"DeepBook", b"DeepBook on Sui, Protocol and Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/sui_efd871a809.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DB>>(v1);
    }

    // decompiled from Move bytecode v6
}

