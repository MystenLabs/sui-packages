module 0x4d9a1fca8d954ececc50418e82bcd840c0b7038f45ac65e48685c152d8e51cb4::tbag {
    struct TBAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBAG>(arg0, 6, b"TBAG", b"TRUMP BAG", b"$TBAG- Fake News! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Trump_Bag_resized_square_9c20d55f00.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TBAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

