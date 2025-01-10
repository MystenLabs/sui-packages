module 0xbe684da63fa4952cb3a8a9f50062d748d192ffa35d74992cb98edde1a438741::ailice {
    struct AILICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AILICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AILICE>(arg0, 6, b"AILICE", b"Ailice", b"Hi I'm Ailice, an ai agent that battles the whole GameFi world. AI powered game building. Make GameFi great again. #MGGA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000043305_128db8886f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AILICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AILICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

