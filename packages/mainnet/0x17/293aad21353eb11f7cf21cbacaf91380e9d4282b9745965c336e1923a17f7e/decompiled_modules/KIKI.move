module 0x17293aad21353eb11f7cf21cbacaf91380e9d4282b9745965c336e1923a17f7e::KIKI {
    struct KIKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIKI>(arg0, 9, b"KIKI", b"KIKI", x"244b494b4920f09fa9b7f09f8da5f09f8cb8f09f92ae20204b696b692c20646f20796f75207374696c6c206c6f7665206d653f202e2e2e2068747470733a2f2f742e6d652f6b696b696f6e736f6c3639", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1747029164215984128/t7-ZnAOp_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIKI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIKI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KIKI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KIKI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

