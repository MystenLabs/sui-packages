module 0x78e4813b74e4d78d462faec6896359bbe41511e08ebed874487d978694250fbf::pikasui {
    struct PIKASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKASUI>(arg0, 6, b"PIKASUI", b"Pikasui", b"A pikachu inspired character with a Sui twist call him", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dfgsdg_75a38c3bb8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIKASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

