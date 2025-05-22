module 0x3fb00a4253094d92fbba2d2fd99166d46066953ea47cd6366202d9baf9a77c08::gsnek {
    struct GSNEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSNEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GSNEK>(arg0, 6, b"GSNEK", b"GOD SNEK", b"GOD OF ALL SNEKS!! CARDANO ALLY! NO RUGS!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747927375201.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GSNEK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSNEK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

