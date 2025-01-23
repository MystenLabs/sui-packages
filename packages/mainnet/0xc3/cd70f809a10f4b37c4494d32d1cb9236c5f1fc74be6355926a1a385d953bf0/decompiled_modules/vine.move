module 0xc3cd70f809a10f4b37c4494d32d1cb9236c5f1fc74be6355926a1a385d953bf0::vine {
    struct VINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VINE>(arg0, 6, b"Vine", b"VineSui", b"We started Vine initially to try and bring people together and reveal what makes us all so special. We impacted culture. Millions of videos were posted. I am launching this coin to commemorate the beauty of togetherness and creation. I will not sell the dev tokens and all profits will be donated to X which has become a beacon for free speech and self expression.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000200492_28475921d3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

