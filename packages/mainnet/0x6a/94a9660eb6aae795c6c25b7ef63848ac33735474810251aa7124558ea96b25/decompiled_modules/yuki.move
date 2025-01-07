module 0x6a94a9660eb6aae795c6c25b7ef63848ac33735474810251aa7124558ea96b25::yuki {
    struct YUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUKI>(arg0, 6, b"YUKI", b"Yuki", b"I love nature, nature is lovely", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_44663b5afc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

