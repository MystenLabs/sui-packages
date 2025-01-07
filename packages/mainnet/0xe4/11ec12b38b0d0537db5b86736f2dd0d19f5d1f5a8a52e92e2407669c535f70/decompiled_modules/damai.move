module 0xe411ec12b38b0d0537db5b86736f2dd0d19f5d1f5a8a52e92e2407669c535f70::damai {
    struct DAMAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAMAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAMAI>(arg0, 6, b"DAMAI", b"DAM AI on SUI", x"62656176657220414920656e67696e656572206279206461792c207375692070726f746563746f72206279206e696768740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_ZEY_0o_R_400x400_1f5559c5c7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAMAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAMAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

