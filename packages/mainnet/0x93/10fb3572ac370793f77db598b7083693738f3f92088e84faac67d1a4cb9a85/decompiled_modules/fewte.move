module 0x9310fb3572ac370793f77db598b7083693738f3f92088e84faac67d1a4cb9a85::fewte {
    struct FEWTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEWTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEWTE>(arg0, 6, b"Fewte", b"ertert", b"tertret", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_21_28_14_2c4a29b1c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEWTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FEWTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

