module 0x50a8b897161bbcbf552bd72716183b8c0e08f2c4a646fd61a09b1e9c6ea11c22::mario {
    struct MARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARIO>(arg0, 6, b"MARIO", b"Mario on Sui", b"Mario's adventure on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733994669271.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARIO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARIO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

