module 0x55b1407f6255a572f1a1788e3e8aeae119b071fb8112ff4de9afe693c49b9f31::straydogs {
    struct STRAYDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRAYDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRAYDOGS>(arg0, 6, b"Straydogs", b"Sdog", x"486572652069732061206375746520646f670a4a7573742062757420697420746f2068656c7020737472617920646f67730a4c6574207573206c697665", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2421_9b7aee9220.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRAYDOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRAYDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

