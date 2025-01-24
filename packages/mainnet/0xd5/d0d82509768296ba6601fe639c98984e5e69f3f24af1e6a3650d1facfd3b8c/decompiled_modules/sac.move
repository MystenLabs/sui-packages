module 0xd5d0d82509768296ba6601fe639c98984e5e69f3f24af1e6a3650d1facfd3b8c::sac {
    struct SAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAC>(arg0, 6, b"SAC", b"SUI ALPHA CALLS COIN", b"BEST SUI CALL CHANNEL ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_img2_b04309cf69.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

