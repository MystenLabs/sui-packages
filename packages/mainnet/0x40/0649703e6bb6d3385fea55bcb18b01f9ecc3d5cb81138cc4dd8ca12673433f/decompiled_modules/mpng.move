module 0x400649703e6bb6d3385fea55bcb18b01f9ecc3d5cb81138cc4dd8ca12673433f::mpng {
    struct MPNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MPNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MPNG>(arg0, 6, b"MPNG", b"MELLOW PENGUIN", b"Cool, calm, and ready to waddle to the top. Mellow Penguin is the chillest meme in town.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_21_031159890_e35b20a1ce.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MPNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MPNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

