module 0x26e0379a1adec2243d20c08b6ab5495cad944bd71747372a726ae1c4ffb4350a::hipposp {
    struct HIPPOSP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPOSP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPOSP>(arg0, 6, b"Hipposp", b"SupperHippo", b"Super hippo hero, living in SUI / memecoin /#SuperHippo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fga8_Z_Esw_400x400_b2039674f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPOSP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPPOSP>>(v1);
    }

    // decompiled from Move bytecode v6
}

