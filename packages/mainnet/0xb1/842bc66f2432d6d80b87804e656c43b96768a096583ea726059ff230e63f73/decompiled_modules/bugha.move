module 0xb1842bc66f2432d6d80b87804e656c43b96768a096583ea726059ff230e63f73::bugha {
    struct BUGHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUGHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUGHA>(arg0, 9, b"BUGHA", b"BUGHA", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/natterhub/image/fetch/c_fit,h_250,w_250/f_auto/q_auto:best/https://assets.natterhub.com/upload/youtubers/34/bugha.jpg?_a=BAAAV6Bs")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUGHA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUGHA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUGHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

