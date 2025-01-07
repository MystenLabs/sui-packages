module 0x918e51b49e287ffcd5ddf6063e43f2ec91066da7c35468cb069ed6589d7d82c3::peny {
    struct PENY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENY>(arg0, 6, b"Peny", b"Penysui", b"I hate jeeters, dont jeet us if u wanna rich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735926896088.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

