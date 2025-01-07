module 0xb727002a57b9ed330c111bec59faf45a2fa5ec55771623bc1036577c18bbb2d7::rhsp {
    struct RHSP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHSP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHSP>(arg0, 6, b"RHSP", b"RED HOT SUI PEPPERS", x"447265616d206f662043616c69666f726e69636174696f6e0a447265616d206f662043616c69666f726e69636174696f6e0a447265616d206f662043616c69666f726e69636174696f6e0a447265616d206f662043616c69666f726e69636174696f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_4e38a90206.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHSP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RHSP>>(v1);
    }

    // decompiled from Move bytecode v6
}

