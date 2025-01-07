module 0xda7155e3c31f943068e8d1fc8fe09f7bb35c7d9bd7f6622855f60728b690790::fam {
    struct FAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAM>(arg0, 6, b"FAM", b"Flying Air Monster", b"Lets fly to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4878_70f7d9bea7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

