module 0x4874b39c322a9f5cc73eac92911e1df67924022a0c2529734be2b22d3a0810ec::blueshib {
    struct BLUESHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUESHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUESHIB>(arg0, 6, b"BLUESHIB", b"BLUE BUBBLE SHIBA", b"Its me, Bubble! Floating through the skies of Sui,bringing joy and looking out for every traveller. There are places youve never imagined waiting to be discovered,and theres always something exciting just ahead.Lets see where were off to next.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3842_2764d97ef8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUESHIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUESHIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

