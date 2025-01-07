module 0x31172eee47a69a0a5e6e198f385286c1f3b71cd73264e89234db7f318ec85a75::dsui {
    struct DSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSUI>(arg0, 8, b"DSUI", b"Dragon On Sui", b"Year of the Dragon On Sui.Website:https://www.dragononsui.com .X: https://twitter.com/Dragononsui .TG: https://t.me/DragonOnSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.dragononsui.com/images/logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DSUI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

