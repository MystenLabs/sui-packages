module 0xbcacc1b6a23df1a20c3a456696b6d30f28430a150d304c85699ae8c722d1b4ef::plump {
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

