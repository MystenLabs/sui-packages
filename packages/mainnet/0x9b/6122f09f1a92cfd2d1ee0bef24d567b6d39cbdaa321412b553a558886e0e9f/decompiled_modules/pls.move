module 0x9b6122f09f1a92cfd2d1ee0bef24d567b6d39cbdaa321412b553a558886e0e9f::pls {
    struct PLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLS>(arg0, 6, b"PLS", b"PrickleOnSui", b"\"Prickle - A trusted companion on the journey to conquer Sui!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_5ed9ed5fc4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

