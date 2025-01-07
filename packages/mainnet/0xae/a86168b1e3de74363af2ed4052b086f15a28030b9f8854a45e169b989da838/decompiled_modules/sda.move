module 0xaea86168b1e3de74363af2ed4052b086f15a28030b9f8854a45e169b989da838::sda {
    struct SDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDA>(arg0, 6, b"SDA", b"SUI DOLPHIN AGENT", b"SUI DOLPHIN AGENT Is building on the sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5773_329c9ee011.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

