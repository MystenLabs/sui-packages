module 0xda27b36d3d4de0d9fdd7b7dbb8739a04caf8895af83a8491e464310ca6120f49::brrr {
    struct BRRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRRR>(arg0, 6, b"Brrr", b" brrr.money", b"Money printer game, brrrrrrrrrrr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730963614121.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRRR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRRR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

