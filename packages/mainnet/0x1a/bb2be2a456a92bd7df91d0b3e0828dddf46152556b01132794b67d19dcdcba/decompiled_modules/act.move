module 0x1abb2be2a456a92bd7df91d0b3e0828dddf46152556b01132794b67d19dcdcba::act {
    struct ACT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACT>(arg0, 6, b"ACT", b"Afrocat", b"Afrocat, inspired by ancient African games, art, and folklore, blends the power and majesty of Africa's heritage with crypto innovation. More than a meme token, it's a dynamic movement in the crypto jungle.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1722976580222_de7f540012220b68377465be4c37887c_1425fc4291.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACT>>(v1);
    }

    // decompiled from Move bytecode v6
}

