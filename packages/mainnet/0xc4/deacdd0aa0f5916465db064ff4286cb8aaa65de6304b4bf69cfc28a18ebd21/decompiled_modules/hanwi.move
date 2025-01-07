module 0xc4deacdd0aa0f5916465db064ff4286cb8aaa65de6304b4bf69cfc28a18ebd21::hanwi {
    struct HANWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANWI>(arg0, 6, b"HANWI", b"Tribe of Hanwi", b"The traditions of the tribe of $HANWI shall take us to the promised land.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dc_Hr_Kn_T9_400x400_6a1cec654a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

