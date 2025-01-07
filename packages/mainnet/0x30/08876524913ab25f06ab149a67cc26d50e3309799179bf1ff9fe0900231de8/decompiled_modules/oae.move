module 0x3008876524913ab25f06ab149a67cc26d50e3309799179bf1ff9fe0900231de8::oae {
    struct OAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OAE>(arg0, 9, b"OAE", b"OAE", b"OAE", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OAE>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OAE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OAE>>(v1);
    }

    // decompiled from Move bytecode v6
}

