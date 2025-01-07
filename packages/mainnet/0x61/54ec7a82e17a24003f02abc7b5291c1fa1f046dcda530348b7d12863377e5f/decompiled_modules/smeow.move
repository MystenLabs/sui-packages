module 0x6154ec7a82e17a24003f02abc7b5291c1fa1f046dcda530348b7d12863377e5f::smeow {
    struct SMEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMEOW>(arg0, 6, b"Smeow", b"Meow on Sui", b"Gmeow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dvdvdvdfv_bf40dc5f74.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMEOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

