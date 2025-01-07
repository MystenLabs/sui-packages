module 0x9ae54c868c15985e916e00aadfdf17afec30dd1ffef3e55047c65a1509d14eab::suipi {
    struct SUIPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPI>(arg0, 6, b"SUIpi", b"SUIPICOIN", b"$SUIPI embark on an icy adventure like no other tands boasting a cutest and charming penguin mascot !!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241008_234003_6f22de2615.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

