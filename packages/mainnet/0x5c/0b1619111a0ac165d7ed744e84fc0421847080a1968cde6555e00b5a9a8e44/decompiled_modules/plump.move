module 0x5c0b1619111a0ac165d7ed744e84fc0421847080a1968cde6555e00b5a9a8e44::plump {
    struct PLUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUMP>(arg0, 6, b"PLUMP", b"Move Plump", b"Us Fatties on $Sui need loving too! $Plump it up!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/eb0a8571_abed_4e02_990d_a886693ee9a0_92cfe5d6dd.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

