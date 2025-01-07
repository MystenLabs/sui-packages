module 0xb270c850593ac86a58c3d153052dc1aae06f621bf393215a0c014b058cd11661::grumpe {
    struct GRUMPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRUMPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRUMPE>(arg0, 6, b"GRUMPE", b"Grumpe", x"4920616d2061206361742d66726f6720687962726964206f66207468652068696768657374206f726465722c20796574206d7920676c6f72696f7573207061777320676f20756e6e6f74696365642e2048756d616e697479e280997320747261676963206f76657273696768742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730952500785.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRUMPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRUMPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

