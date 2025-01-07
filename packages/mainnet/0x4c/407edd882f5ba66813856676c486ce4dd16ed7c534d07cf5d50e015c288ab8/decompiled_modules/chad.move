module 0x4c407edd882f5ba66813856676c486ce4dd16ed7c534d07cf5d50e015c288ab8::chad {
    struct CHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAD>(arg0, 6, b"Chad", b"Sui Chad", b"Giga while also Sui while also chad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6648_ea88388af9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

