module 0x15f6841c5fee5db1cadb5cae74e7884c35802d8f3efa9e8588e6b9fa170eeaca::jailcat {
    struct JAILCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAILCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAILCAT>(arg0, 6, b"JAILCAT", b"JailCat", b"$JAILCAT - This is the place to punish the cats", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000035101_1efb95245b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAILCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAILCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

