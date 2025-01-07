module 0x789297be05a1fab57db7f21d093b45a8d962175c130e118f67ce91ddb6d71b54::bapbul {
    struct BAPBUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAPBUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAPBUL>(arg0, 6, b"BAPBUL", b"BAPBUL On Sui", b"$BAPBUL is the cutest and viral dog on the internet, she's too adorable .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731817384914.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAPBUL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAPBUL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

