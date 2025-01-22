module 0x99b18c75bcb1871ff099576da1f2ec839428ea61a3c2af5450a05be4af96ead2::grumpy {
    struct GRUMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRUMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRUMPY>(arg0, 6, b"GRUMPY", b"OG GRUMPY TRUMP OFFICIAL", b"GRUMPY TRUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_6091192155163967599_y_a673929a85.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRUMPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRUMPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

