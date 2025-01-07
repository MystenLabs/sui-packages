module 0x79dd60f16d5ca9dae9134761e98e27b20f7dc768d8ab3514f90542f853990bca::berry {
    struct BERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BERRY>(arg0, 6, b"Berry", b"Berry the trader", b"Berry is the new autistic trader.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/659a1f47_dad0_403c_93ea_54b1d046fe6d_c3a0997f3e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

