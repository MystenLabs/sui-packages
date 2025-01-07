module 0x4550a8ef25b2ce6f37209ddc857a87ec33b6d1ce30ea3cb30d23a976e88bf00c::pupi {
    struct PUPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPI>(arg0, 9, b"PUPI", b"PepeMarihuano", b"MarihuanaFree", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTsDKkwvq9VYaiSk2ydFWNwcPEjYHcntAe7Hw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUPI>(&mut v2, 22222222000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

