module 0xc227b7eaf31ac943813016f6090bf64346f19423705dac92cbe34d28e84b38d1::chomp {
    struct CHOMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOMP>(arg0, 6, b"CHOMP", b"CH0MP", b"WELCOME TO CHOMP. SUI'S FIERCE LITTLE FUZZBALL! THIS GUINEA PIG'S NOT JUST CUTE, HE'S HERE TO RATTLE THE CAGE! ORANGE IS THE NEW BLUE, SO JOIN US IN THIS WILD DEGEN ADVENTURE...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_05_47_07_76c24bd013.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

