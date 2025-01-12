module 0xe9fa3dec698aca9754fa491d7690abf59b8a0d0006d6cd4f5e815376de32bcb9::ton {
    struct TON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TON>(arg0, 6, b"TON", b"Ton Token", b"ton meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/ce599c52-c20d-4a2c-8b40-040f23b52411.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

