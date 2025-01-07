module 0xe38a4dda8e6ef024459a4ce401be10258f22b8681a50d60f30629f2d1a589cca::kpx {
    struct KPX has drop {
        dummy_field: bool,
    }

    fun init(arg0: KPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KPX>(arg0, 6, b"KPX", b"KAMEIPIXEL", b"It's a coincidence that we met here, this is meme pokemon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bepe_burn_f6dcb86c16.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KPX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KPX>>(v1);
    }

    // decompiled from Move bytecode v6
}

