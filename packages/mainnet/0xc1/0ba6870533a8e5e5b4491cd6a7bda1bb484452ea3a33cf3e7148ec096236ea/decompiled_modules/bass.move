module 0xc10ba6870533a8e5e5b4491cd6a7bda1bb484452ea3a33cf3e7148ec096236ea::bass {
    struct BASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASS>(arg0, 6, b"BASS", b"Big ass", b"There is a beautiful ass facing you every day, are you excited?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_ae_a_2024_10_07_211249_f5b2fbc5c8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

