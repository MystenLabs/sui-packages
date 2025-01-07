module 0xf0d1a8fc86719fd34218921058390b9c50e720ea55eb6019956e7df6ae3e6934::suizuki {
    struct SUIZUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZUKI>(arg0, 6, b"SUIZUKI", b"Suizuki", b"$SUIZUKI was born to bring the idea of the fastest chain in the block actually, sui is the best network ever made and it's coming for this bullrun on this end of year.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a0f3b61d_1c70_4f1c_88e5_34290994b364_3fe015332a.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZUKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

