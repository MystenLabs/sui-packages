module 0x4fcddfef82a0c231218068e94c8a28c31df9165b12cfb23bde2a457fabe2b454::carl {
    struct CARL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARL>(arg0, 6, b"CARL", b"Carl the Hedgehog", b"I like naps, snacks, and pretending to be productive.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055002_cc8408be7d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARL>>(v1);
    }

    // decompiled from Move bytecode v6
}

