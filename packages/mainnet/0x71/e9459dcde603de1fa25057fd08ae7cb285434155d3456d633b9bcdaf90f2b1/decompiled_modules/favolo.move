module 0x71e9459dcde603de1fa25057fd08ae7cb285434155d3456d633b9bcdaf90f2b1::favolo {
    struct FAVOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAVOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAVOLO>(arg0, 6, b"FAVOLO", b"Favolo On Sui", b"Welcome to Favolo's world! Meet Favolo, the crazy Chihuahua of Sui Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018247_06a6c75253.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAVOLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAVOLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

