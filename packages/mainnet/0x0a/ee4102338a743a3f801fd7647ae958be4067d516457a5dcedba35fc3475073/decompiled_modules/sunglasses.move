module 0xaee4102338a743a3f801fd7647ae958be4067d516457a5dcedba35fc3475073::sunglasses {
    struct SUNGLASSES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNGLASSES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNGLASSES>(arg0, 6, b"Sunglasses", b"Sunglasses Duck", b"A duck wearing sunglasses, cool!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/h_SR_0_Vj_Yh_400x400_aa09d7b99e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNGLASSES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNGLASSES>>(v1);
    }

    // decompiled from Move bytecode v6
}

