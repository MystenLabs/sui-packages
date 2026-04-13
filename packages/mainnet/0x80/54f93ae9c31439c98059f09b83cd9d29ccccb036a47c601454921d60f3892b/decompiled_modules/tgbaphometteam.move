module 0x8054f93ae9c31439c98059f09b83cd9d29ccccb036a47c601454921d60f3892b::tgbaphometteam {
    struct TGBAPHOMETTEAM has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TGBAPHOMETTEAM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TGBAPHOMETTEAM>>(0x2::coin::mint<TGBAPHOMETTEAM>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TGBAPHOMETTEAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<TGBAPHOMETTEAM>(arg0, 9, b"XSS", b"tgBaphometTeam", x"7467426170686f6d65745465616d20285853532920e28094204f6666696369616c20746f6b656e206f662074686520426170686f6d6574205465616d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/wZtTgCzS/favicon2.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TGBAPHOMETTEAM>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<TGBAPHOMETTEAM>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TGBAPHOMETTEAM>>(v0);
    }

    // decompiled from Move bytecode v6
}

