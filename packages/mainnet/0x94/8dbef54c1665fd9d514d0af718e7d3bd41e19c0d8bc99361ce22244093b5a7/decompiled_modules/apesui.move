module 0x948dbef54c1665fd9d514d0af718e7d3bd41e19c0d8bc99361ce22244093b5a7::apesui {
    struct APESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: APESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APESUI>(arg0, 6, b"Apesui", b"Money Ape", b"Little Ape Print out Money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_09_at_02_08_22_6932ea4a_fb95fccc92.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

