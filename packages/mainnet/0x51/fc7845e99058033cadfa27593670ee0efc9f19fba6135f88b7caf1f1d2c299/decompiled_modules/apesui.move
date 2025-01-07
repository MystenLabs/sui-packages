module 0x51fc7845e99058033cadfa27593670ee0efc9f19fba6135f88b7caf1f1d2c299::apesui {
    struct APESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: APESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APESUI>(arg0, 6, b"APE", b"ApeSui", b"Telegram: https://t.me/apesui_ann", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/uY9apzk.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APESUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APESUI>>(v0, @0xfb376d3d2282d556e7fc1a7a20af3394d89576f1633af6f078fcb36f53da2514);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<APESUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<APESUI>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

