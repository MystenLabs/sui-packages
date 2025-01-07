module 0x5bce745e3348e64a306f9de66bb086486e6d418f49a7de730fae4d11e8f59bd::mutha {
    struct MUTHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUTHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUTHA>(arg0, 6, b"MUTHA", b"MuthaFumpkin", b"Meet Mutha Fumpkin - The badass pumpkin-headed enforcer bringing spice to  that spice to the game.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mutha_87b97bf326.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUTHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUTHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

