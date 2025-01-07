module 0x22fbec5e8311f6c3c83038f0b7244b16e9e3284a6679d02d16a456cc1bc66dd5::vlc {
    struct VLC has drop {
        dummy_field: bool,
    }

    fun init(arg0: VLC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VLC>(arg0, 6, b"VLC", b"VLC MEDIA PLAYER", b"bEST MEDIA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_041e4b38f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VLC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VLC>>(v1);
    }

    // decompiled from Move bytecode v6
}

