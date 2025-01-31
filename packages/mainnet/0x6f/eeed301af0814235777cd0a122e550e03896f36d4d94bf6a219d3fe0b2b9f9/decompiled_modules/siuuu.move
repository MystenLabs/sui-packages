module 0x6feeed301af0814235777cd0a122e550e03896f36d4d94bf6a219d3fe0b2b9f9::siuuu {
    struct SIUUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIUUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIUUU>(arg0, 6, b"SIUUU", b"New Token", b"new token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/ea433680-dfdb-11ef-9dba-070b578638a0")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIUUU>>(v1);
        0x2::coin::mint_and_transfer<SIUUU>(&mut v2, 1100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIUUU>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

