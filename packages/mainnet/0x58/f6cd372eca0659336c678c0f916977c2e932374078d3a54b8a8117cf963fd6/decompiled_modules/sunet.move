module 0x58f6cd372eca0659336c678c0f916977c2e932374078d3a54b8a8117cf963fd6::sunet {
    struct SUNET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNET>(arg0, 6, b"SUNET", b"sunet", b"SUNET ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1234_3235eeec1d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNET>>(v1);
    }

    // decompiled from Move bytecode v6
}

