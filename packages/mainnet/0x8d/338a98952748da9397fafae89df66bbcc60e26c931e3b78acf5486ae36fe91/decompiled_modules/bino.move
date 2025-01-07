module 0x8d338a98952748da9397fafae89df66bbcc60e26c931e3b78acf5486ae36fe91::bino {
    struct BINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BINO>(arg0, 6, b"BINO", b"BINOSAURUS", x"544845205245414c202442494e4f204a555354204152524956454421210a42494e4f206973206e6f74206a75737420616e6f746865722063727970746f63757272656e63793b2069742773206120636f6d706c6574652065636f73797374656d2064657369676e656420746f20706f7765722074686520667574757265206f6620646563656e7472616c697a65642066696e616e63652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asds_e4c2b3cbb7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

