module 0xcdbb8b5fdeeae12f5eab00f3458b8125d19e26b836f9d759baf528633a5cfc90::Gandoge {
    struct GANDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GANDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GANDOGE>(arg0, 6, b"GANDOGE", b"GANDOGE", b"The only wizard dog that knows how to HODL the line", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://sui-api-mainnet.bluemove.net/uploads/GANDOGE_acbf01b9a6.WEBP"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GANDOGE>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GANDOGE>(&mut v2, 3000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GANDOGE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

