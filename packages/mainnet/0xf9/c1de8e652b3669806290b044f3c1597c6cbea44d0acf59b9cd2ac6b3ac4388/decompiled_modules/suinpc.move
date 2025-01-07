module 0xf9c1de8e652b3669806290b044f3c1597c6cbea44d0acf59b9cd2ac6b3ac4388::suinpc {
    struct SUINPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINPC>(arg0, 6, b"SUINPC", b"SUI NPC", b"I SUPPORT THE CURRENT THING!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_e1b8ebad1c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

