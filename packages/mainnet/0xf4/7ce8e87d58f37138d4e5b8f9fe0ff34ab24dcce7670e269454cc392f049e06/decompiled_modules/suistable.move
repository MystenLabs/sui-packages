module 0xf47ce8e87d58f37138d4e5b8f9fe0ff34ab24dcce7670e269454cc392f049e06::suistable {
    struct SUISTABLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISTABLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISTABLE>(arg0, 6, b"SuiStable", b"SUI The Stable Coin ", b"Finally sui reached $1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1789985222711.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISTABLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISTABLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

