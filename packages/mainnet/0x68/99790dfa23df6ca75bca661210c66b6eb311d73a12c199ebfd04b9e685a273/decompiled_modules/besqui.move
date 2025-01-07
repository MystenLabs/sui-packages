module 0x6899790dfa23df6ca75bca661210c66b6eb311d73a12c199ebfd04b9e685a273::besqui {
    struct BESQUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BESQUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BESQUI>(arg0, 6, b"BESQUI", b"Blue eye squid", b"Blue eye squid is sending waves through the sui sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5519_7ea3dc04d0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BESQUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BESQUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

