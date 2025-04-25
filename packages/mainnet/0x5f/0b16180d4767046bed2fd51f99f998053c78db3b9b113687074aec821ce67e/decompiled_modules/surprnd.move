module 0x5f0b16180d4767046bed2fd51f99f998053c78db3b9b113687074aec821ce67e::surprnd {
    struct SURPRND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURPRND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURPRND>(arg0, 6, b"Surprnd", b"Gsisnts", b"Ngdsoognss ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8358_7ee27aba08.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURPRND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SURPRND>>(v1);
    }

    // decompiled from Move bytecode v6
}

