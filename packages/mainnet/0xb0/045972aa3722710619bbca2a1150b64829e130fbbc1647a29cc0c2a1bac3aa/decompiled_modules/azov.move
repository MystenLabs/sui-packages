module 0xb0045972aa3722710619bbca2a1150b64829e130fbbc1647a29cc0c2a1bac3aa::azov {
    struct AZOV has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZOV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AZOV>(arg0, 6, b"AZOV", b"Azov", b"Support Azov", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d4497f5dfcb0105ed1d8deb94bc867f0199d3c69_70e27a132e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZOV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AZOV>>(v1);
    }

    // decompiled from Move bytecode v6
}

