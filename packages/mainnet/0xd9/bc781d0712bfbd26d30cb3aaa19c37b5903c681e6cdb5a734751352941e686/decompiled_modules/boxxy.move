module 0xd9bc781d0712bfbd26d30cb3aaa19c37b5903c681e6cdb5a734751352941e686::boxxy {
    struct BOXXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOXXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOXXY>(arg0, 6, b"Boxxy", b"Boxxy on Sui", b"Meet BOXXY, a truly original character in a world full of copycats. BOXXY loves outsmarting copycats, playing pranks, and surprising everyone with unpredictable moves. You gotta love BOXXY.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_2e47779556.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOXXY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOXXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

