module 0xdb73fd657af30c855e190fe1378c348216354d0b9ff36edd54d3ac2c39e8a2de::dr {
    struct DR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DR>(arg0, 9, b"DR", b"Drogoof", b"A water drop with more enthusiasm than sense  - Drogoof is here to splash chaos into the memecoin world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4d008ab1254e86c0f6807856ed942804blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

