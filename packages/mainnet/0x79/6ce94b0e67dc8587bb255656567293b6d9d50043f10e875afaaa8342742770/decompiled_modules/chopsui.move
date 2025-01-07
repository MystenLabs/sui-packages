module 0x796ce94b0e67dc8587bb255656567293b6d9d50043f10e875afaaa8342742770::chopsui {
    struct CHOPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOPSUI>(arg0, 6, b"CHOPSUI", b"chopsui", b"Chop suey is a dish from American Chinese cuisine and other forms of overseas Chinese cuisine, generally consisting of meat and eggs, cooked quickly with vegetables such as bean sprouts, cabbage, and celery, and bound in a starch-thickened sauce. It is typically served with rice but can become the Chinese-American form of chow mein with the substitution of stir-fried noodles for rice.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fsf6_Hhr_Wc_Ag_Rm_BB_cacee8966b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

