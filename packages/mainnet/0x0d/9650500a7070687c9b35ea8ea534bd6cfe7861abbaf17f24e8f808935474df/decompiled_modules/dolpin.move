module 0xd9650500a7070687c9b35ea8ea534bd6cfe7861abbaf17f24e8f808935474df::dolpin {
    struct DOLPIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPIN>(arg0, 6, b"Dolpin", b"DOLPIN", b"We aim to become one of the leading memecoins on the Sui network, fostering positive interactions between investors and users. We are committed to adding value to our community and creating an enjoyable experience for everyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241031_031943_939_fc963a1380.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLPIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

