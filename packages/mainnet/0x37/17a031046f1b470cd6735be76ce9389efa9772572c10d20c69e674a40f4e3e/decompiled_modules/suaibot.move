module 0x3717a031046f1b470cd6735be76ce9389efa9772572c10d20c69e674a40f4e3e::suaibot {
    struct SUAIBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUAIBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUAIBOT>(arg0, 6, b"SUAIBOT", b"SUAI BOT by SuiAI", x"5355494120424f54206973206865726520746f207265766f6c7574696f6e697a652074726164696e67206f6e207468652053756920636861696e207769746820706f77657266756c2066656174757265733a2e2ee29c8520446567656e204d6f64652ee29c85204175746f6d617465642054726164696e672ee29c85204c696d6974204f72646572732ee29c8520536e697065732ee29c852052756720416c6572742e2e546869732069732074686520756c74696d6174652041492d706f77657265642074726164696e6720746f6f6c2064657369676e656420666f722074686520667574757265206f662074686520245355492065636f73797374656d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_6665_869be84fb8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUAIBOT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUAIBOT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

