module 0xdcb53e6a03d6a242b449eecfdeae6a98599ddc243b4f28ef4bc7e7195f90e5fc::hsoc {
    struct HSOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSOC>(arg0, 6, b"HSOC", b"HUSOCOIN", b"They call him Huso, It's lovely Dog, let's make some fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PHOTO_2023_09_03_19_28_44_db435a73df.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSOC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HSOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

