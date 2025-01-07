module 0x7adeb6a645caf38e19c6d1b3838e463a161b91766d0811491877d0473c22db8e::friz {
    struct FRIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRIZ>(arg0, 6, b"Friz", b"Friz cowboy", b"If it hadn't been for Cotton Eye Joe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/IMG_20240924_224247_587_25f6d48520.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRIZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRIZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

