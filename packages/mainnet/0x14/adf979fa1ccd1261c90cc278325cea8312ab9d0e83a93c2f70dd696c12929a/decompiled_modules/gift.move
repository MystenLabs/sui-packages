module 0x14adf979fa1ccd1261c90cc278325cea8312ab9d0e83a93c2f70dd696c12929a::gift {
    struct GIFT has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GIFT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GIFT>>(0x2::coin::mint<GIFT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GIFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIFT>(arg0, 9, b"GIFT", b"Sui Gift", b"A gift token on Sui, sent to test wallet visibility.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://placehold.co/240x240/4da2ff/ffffff/png?text=GIFT")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIFT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIFT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

