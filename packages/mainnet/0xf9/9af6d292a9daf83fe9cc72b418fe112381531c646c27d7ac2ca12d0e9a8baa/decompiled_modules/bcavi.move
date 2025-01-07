module 0xf99af6d292a9daf83fe9cc72b418fe112381531c646c27d7ac2ca12d0e9a8baa::bcavi {
    struct BCAVI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCAVI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCAVI>(arg0, 6, b"BCAVI", b"Blue Caviar", b"An incredibly premium delicacy for all connoisseurs of luxury. It simply must be in every wallet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732644023806.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BCAVI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCAVI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

