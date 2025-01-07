module 0x23f1dc3f5b99be728a114095c42cf50e4e8ce7a4092716723220bce935ee9b3d::kiki {
    struct KIKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIKI>(arg0, 6, b"KIKI", b"Kiki Flaminki", b"Kiki Flaminki, the coolest bird in crypto!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000021985_9e7da957e5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

