module 0x3ce2f653618b454654b4f3e662150408d4cf7f813db1e33bb22ec69a073d8925::vunart {
    struct VUNART has drop {
        dummy_field: bool,
    }

    fun init(arg0: VUNART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VUNART>(arg0, 6, b"VUNART", b"VUN ART", b"Start to manage your collectibles on SUI Network. VUN ART's sleek design and user-friendly features make the experience enjoyable and efficient.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_26_23_16_48_96f5837a26.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VUNART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VUNART>>(v1);
    }

    // decompiled from Move bytecode v6
}

