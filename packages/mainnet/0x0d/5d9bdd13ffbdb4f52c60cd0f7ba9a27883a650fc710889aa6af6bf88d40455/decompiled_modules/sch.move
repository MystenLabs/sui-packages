module 0xd5d9bdd13ffbdb4f52c60cd0f7ba9a27883a650fc710889aa6af6bf88d40455::sch {
    struct SCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCH>(arg0, 9, b"SCH", b"SuiCash", b"Suicash is the epitome of wealth meets swag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suicash.com/wp-content/uploads/2023/12/cropped-sui-sui-coin-9177503-7479564.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SCH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

