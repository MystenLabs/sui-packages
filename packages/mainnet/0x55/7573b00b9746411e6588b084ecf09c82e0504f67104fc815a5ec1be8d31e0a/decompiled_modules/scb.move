module 0x557573b00b9746411e6588b084ecf09c82e0504f67104fc815a5ec1be8d31e0a::scb {
    struct SCB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCB>(arg0, 6, b"SCB", b"Sui Cheese Ball", b"Sui Cheese Ball!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_Ykn_F_Lui_400x400_6f88c5b262.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCB>>(v1);
    }

    // decompiled from Move bytecode v6
}

