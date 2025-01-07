module 0x5a86608c378b01506d0f5a77dc86f349dc8f6c7300d4c55710556e4281accb20::dsmaga {
    struct DSMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSMAGA>(arg0, 6, b"DSMAGA", b"Dark Sui Maga", b"The Dark Sui Maga patriots are in control.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/animation_gif_ezgif_com_video_to_gif_converter_669a346c06.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSMAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSMAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

