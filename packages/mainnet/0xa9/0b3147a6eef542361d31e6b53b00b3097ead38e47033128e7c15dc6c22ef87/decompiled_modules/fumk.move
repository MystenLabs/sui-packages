module 0xa90b3147a6eef542361d31e6b53b00b3097ead38e47033128e7c15dc6c22ef87::fumk {
    struct FUMK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUMK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUMK>(arg0, 6, b"FUMK", b"$FUMK", b"Let's take flight together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_2a05715241.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUMK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUMK>>(v1);
    }

    // decompiled from Move bytecode v6
}

