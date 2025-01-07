module 0x54c9ba10c614e2c38fd69ab3ee1c5399f3ba65baa60355f63a6b4f99519ca86a::kop {
    struct KOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOP>(arg0, 6, b"KOP", b"KING OF POP", b"They call me \"King Chi\"  short for King of Pop, with that Chihuahua sass MF.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mj_496386f689.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

