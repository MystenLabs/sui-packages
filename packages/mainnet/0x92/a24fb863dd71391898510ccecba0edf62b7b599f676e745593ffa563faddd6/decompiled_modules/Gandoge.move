module 0x92a24fb863dd71391898510ccecba0edf62b7b599f676e745593ffa563faddd6::Gandoge {
    struct GANDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GANDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GANDOGE>(arg0, 6, b"GANDOGE", b"GANDOGE", b"The only wizard dog that knows how to HODL the line", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://sui-api-mainnet.bluemove.net/uploads/D_C_Ma_9_BRU_2_Yy_R9_ZWZ_1vt_A_962bc1951f.WEBP"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GANDOGE>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GANDOGE>(&mut v2, 3000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GANDOGE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

