module 0x67300e83bee6748181a688377fc8cd392e7e5405c70a08f2a74798b9b1c2b131::suishib {
    struct SUISHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIB>(arg0, 6, b"SUISHIB", b"SUI SHIB", b"Suishib is not just about investmentit's an epic adventure in the super-fast #Sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Miz1hoyx_400x400_e547014f5a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

