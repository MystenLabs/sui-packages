module 0xe3e2bf8c4a9f886a3aec02b16efc36a416f34fd69a47e26ce8c681bcc74e2d::bubsui {
    struct BUBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBSUI>(arg0, 6, b"BUBSUI", b"BUBCAT ON SUI", b"BUBCAT ON SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/200_9391cf363d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

