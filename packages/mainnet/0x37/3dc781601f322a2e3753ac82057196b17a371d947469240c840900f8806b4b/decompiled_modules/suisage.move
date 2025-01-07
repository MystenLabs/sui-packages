module 0x373dc781601f322a2e3753ac82057196b17a371d947469240c840900f8806b4b::suisage {
    struct SUISAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISAGE>(arg0, 9, b"SUISAGE", b"Suisage", b"..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.openart.ai/published/XpjfWHlfqU2HHxu5NaTK/G_-tNMfP_yYl2_1024.webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISAGE>(&mut v2, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISAGE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

