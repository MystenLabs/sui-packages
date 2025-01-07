module 0xa444235ade901fcb163c79f4a06b0de039709a092c3f0db02716cbb0a3ca3810::sumi {
    struct SUMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMI>(arg0, 9, b"SUMI", b"Natsumi", b"Wop wop wop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgdlvr.com/pic/photoresizer.com/20240602-7802/public")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUMI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

