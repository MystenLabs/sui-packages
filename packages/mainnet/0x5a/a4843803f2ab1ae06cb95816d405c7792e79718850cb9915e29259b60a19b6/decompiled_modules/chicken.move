module 0x5aa4843803f2ab1ae06cb95816d405c7792e79718850cb9915e29259b60a19b6::chicken {
    struct CHICKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHICKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHICKEN>(arg0, 6, b"CHICKEN", b"Chicken Road", b"Chicken Road - The First 8-bit endless arcade hopper on the Sui Blockchain that started it all. Collect custom characters and navigate freeways, railroads, rivers and much more.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250116_185711_65989dd545.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHICKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHICKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

