module 0xfe998eec6177c1754388b9b4315fb354f1b3435c38ee4aa43aed2c53cc25dae1::brainlet {
    struct BRAINLET has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAINLET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAINLET>(arg0, 6, b"BRAINLET", b"Brainlet", b"Brainlet pair launch on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRB7tFLpP-9S8iME7Z8AcOCjT_4kE5uYgfAkw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BRAINLET>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAINLET>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRAINLET>>(v1);
    }

    // decompiled from Move bytecode v6
}

