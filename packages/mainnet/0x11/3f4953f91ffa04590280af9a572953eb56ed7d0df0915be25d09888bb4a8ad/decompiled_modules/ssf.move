module 0x113f4953f91ffa04590280af9a572953eb56ed7d0df0915be25d09888bb4a8ad::ssf {
    struct SSF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSF>(arg0, 6, b"SSF", b"Suistarfish", b"A starfish wandering in the sea, afraid of being eaten by big fish.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c8f5349b_b18c_48d4_a4c6_fe71f6de8194_1_633e46d205.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSF>>(v1);
    }

    // decompiled from Move bytecode v6
}

