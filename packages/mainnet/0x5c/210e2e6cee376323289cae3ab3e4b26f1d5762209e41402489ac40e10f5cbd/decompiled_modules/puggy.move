module 0x5c210e2e6cee376323289cae3ab3e4b26f1d5762209e41402489ac40e10f5cbd::puggy {
    struct PUGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGGY>(arg0, 6, b"PUGGY", b"$PUGGY", b"PUGGY the memecoin for everyone! Join a vibrant community driven by hard work and humor as we embark on a fun-filled ride to the moon and beyond.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241018_135856_658_39f80fb2ba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

