module 0x5d50584a00f43abdb41e9bcc7c9cc719746a5adc397f158815ca6f94b3f47b6d::PEPA {
    struct PEPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPA>(arg0, 9, b"PEPA", b"PEPA", b"Pepa's ready for adventure and fun,  join her on SUI Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1746629690024955905/vgKpts67_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PEPA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

