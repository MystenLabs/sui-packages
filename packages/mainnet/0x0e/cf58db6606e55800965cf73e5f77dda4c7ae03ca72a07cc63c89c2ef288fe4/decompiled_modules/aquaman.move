module 0xecf58db6606e55800965cf73e5f77dda4c7ae03ca72a07cc63c89c2ef288fe4::aquaman {
    struct AQUAMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUAMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUAMAN>(arg0, 6, b"AQUAMAN", b"SUPERHERO BLUE", b"Superhero blue $AQUAMAN, heroes on SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/54_F1_AA_56_51_F6_4970_91_B3_661140528_DC_6_fb3ff30177.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUAMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUAMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

