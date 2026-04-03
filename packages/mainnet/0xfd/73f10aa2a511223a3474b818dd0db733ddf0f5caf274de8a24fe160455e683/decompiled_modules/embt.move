module 0xfd73f10aa2a511223a3474b818dd0db733ddf0f5caf274de8a24fe160455e683::embt {
    struct EMBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMBT>(arg0, 6, b"EMBT", b"Ember Talon", b"Protector of roof tops and collector of crumbs Ember Talon is the most fierce pigeon known to man.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1775248541245.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EMBT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMBT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

