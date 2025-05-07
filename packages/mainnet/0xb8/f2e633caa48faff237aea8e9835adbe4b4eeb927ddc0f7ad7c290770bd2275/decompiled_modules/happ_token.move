module 0xb8f2e633caa48faff237aea8e9835adbe4b4eeb927ddc0f7ad7c290770bd2275::happ_token {
    struct HAPP_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAPP_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAPP_TOKEN>(arg0, 9, b"HAPP Token", b"HAPP", b"Hope everyone to be happy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/Cetus_f2d8b47579.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HAPP_TOKEN>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPP_TOKEN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAPP_TOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

