module 0x70ca1e6b9d9abe6f4b4768c67881042b38a8e6bc7f2cf028e01541a2467dbcdc::openclawassitant {
    struct OPENCLAWASSITANT has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<OPENCLAWASSITANT>, arg1: 0x2::coin::Coin<OPENCLAWASSITANT>) {
        0x2::coin::burn<OPENCLAWASSITANT>(arg0, arg1);
    }

    fun init(arg0: OPENCLAWASSITANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPENCLAWASSITANT>(arg0, 6, b"OpenClawAssitant", b"OpenClawAssitant", b"OpenClawAssitant", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OPENCLAWASSITANT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPENCLAWASSITANT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<OPENCLAWASSITANT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<OPENCLAWASSITANT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

