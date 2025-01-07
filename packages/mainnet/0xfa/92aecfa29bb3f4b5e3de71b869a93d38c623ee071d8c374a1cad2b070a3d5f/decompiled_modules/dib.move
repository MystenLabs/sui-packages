module 0xfa92aecfa29bb3f4b5e3de71b869a93d38c623ee071d8c374a1cad2b070a3d5f::dib {
    struct DIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIB>(arg0, 6, b"DIB", b"Dev-is-broken", b"Help the dev his broke ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/devis_broke_2_c636c17bbf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

