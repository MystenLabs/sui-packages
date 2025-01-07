module 0x1ff551228b0d3488a4df8c7cadab07090ddbe4b172a5798815d311a5abf61524::dduck {
    struct DDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDUCK>(arg0, 6, b"DDUCK", b"Dagobert Duck", b"The richest memecoin in the world! Ready to take over the crypto World", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000021966_e9924f16cd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

