module 0xaa229cbeb9baac4b9ee08e71afd7610237e82024e879d510c720d4e6de1b8ba7::cwiff {
    struct CWIFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWIFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWIFF>(arg0, 6, b"CWIFF", b"CAT WIF SUI", b"its not a crab , its not dog , its a CAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catwif_a1501c590d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWIFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CWIFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

