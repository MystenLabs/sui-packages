module 0x5856e61302ab8b15614f214827bed9485d7925d623ac7fb7aee7091888b8c665::fogy {
    struct FOGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOGY>(arg0, 6, b"FOGY", b"Fogy", b"Hey i'm Fogy the frog!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FOGY_9f66353fcb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

