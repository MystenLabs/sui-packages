module 0xdde098d9b09cb8249ceda912831294a7deeb44af20760b51d085cf89bcf085e0::Hello_World {
    struct HELLO_WORLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLO_WORLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLO_WORLD>(arg0, 9, b"Hello", b"Hello World", b"hello and welcome", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/ea6b9b6f-c860-4796-ba7d-ca3b6a4af965.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELLO_WORLD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLO_WORLD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

