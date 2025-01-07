module 0x1a9ab805184fd0ced126b185b2732e5ae10a9659f89951662b07bac61de2e047::banger {
    struct BANGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANGER>(arg0, 6, b"Banger", b"SuiSage", b"Meet this beautiful banger SUISAGE!!! Fresh out the Sui kitchen cooked to perfection ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tg_1342fd138d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

