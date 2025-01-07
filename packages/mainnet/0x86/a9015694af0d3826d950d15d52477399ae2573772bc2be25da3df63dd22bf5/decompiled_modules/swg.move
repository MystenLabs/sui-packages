module 0x86a9015694af0d3826d950d15d52477399ae2573772bc2be25da3df63dd22bf5::swg {
    struct SWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWG>(arg0, 6, b"SWG", b"Smilling Water Girl", b"Talkless just fly higher", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_11_25_at_13_45_01_4ffb272d4d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWG>>(v1);
    }

    // decompiled from Move bytecode v6
}

