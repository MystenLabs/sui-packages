module 0x8385cb5ccea73a881d816eb115d8c11982586fa927ffaf2d94c1ebc26e670158::what {
    struct WHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHAT>(arg0, 9, b"WHAT", b"WHAT", b"Whatever Hate At Toes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkjmKy6a1gal-g6LnwGpAjyE0AiF-Kb4qISQ&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WHAT>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

