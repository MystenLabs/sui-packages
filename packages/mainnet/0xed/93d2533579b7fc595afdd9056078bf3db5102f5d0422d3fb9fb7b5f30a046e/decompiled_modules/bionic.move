module 0xed93d2533579b7fc595afdd9056078bf3db5102f5d0422d3fb9fb7b5f30a046e::bionic {
    struct BIONIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIONIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIONIC>(arg0, 6, b"BIONIC", b"BIONIC SUI", b"Bionic Sui is not just an ordinary characterits a digital guardian equipped with bionic power, born from the hidden technology buried deep within the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bio_new_4d545f0bab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIONIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIONIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

