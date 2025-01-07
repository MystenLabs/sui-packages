module 0x6b24b9d56b2aef87f4de5a8e8fb7b36474fb3577994963f46f9f91654ebf7640::salmono {
    struct SALMONO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALMONO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALMONO>(arg0, 6, b"SALMONO", b"Salmono", b"I AM SALMONO THE KING OF THE SEA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/salmono_1cb0fdf4bb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALMONO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SALMONO>>(v1);
    }

    // decompiled from Move bytecode v6
}

