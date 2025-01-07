module 0x636ddcc5b743ee045104301f27a4d0eeae26d4881711877b87a4452fa91c50d2::gatto {
    struct GATTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GATTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GATTO>(arg0, 6, b"GATTO", b"Gatto On Sui", b"Gatto is a cat that often makes a mess and sometimes poses a threat to its environment. At times he is thought to be an alien. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000429_750951827a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GATTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GATTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

