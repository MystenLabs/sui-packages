module 0x675386aa5bea45b5804d8a4c262413dbd11960af9b16e3f4603c9c046f31957d::owls {
    struct OWLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWLS>(arg0, 6, b"OWLS", b"OwledSui", b"Owled welcomes you to Suinetwork! Join Owled in exploring the mysteries of the blockchain world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/32_a3dfa1772c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OWLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

