module 0x3b1e2162b4583952a4bbc7923cabc3159a5b0bd5e90898eac5c059083886410::maui {
    struct MAUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAUI>(arg0, 6, b"MAUI", b"MAUI by Matt Furie", b"Yo, let me tell you about $MAUI. This dude's straight ouuta matt furie's wild imagination, rocking a head that's like a full blown volcano.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000114678_c032f9f727.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

