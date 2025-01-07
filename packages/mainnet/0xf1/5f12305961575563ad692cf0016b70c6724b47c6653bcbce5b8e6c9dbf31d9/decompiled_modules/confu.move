module 0xf15f12305961575563ad692cf0016b70c6724b47c6653bcbce5b8e6c9dbf31d9::confu {
    struct CONFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONFU>(arg0, 6, b"CONFU", b"Confusuis", b"A man of wisdom delights in water", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2525_a3d56e7507.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONFU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CONFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

