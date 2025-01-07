module 0x6ccb2045fa041259202feedc4938c128b783dc20c53d8520bec98beb68e81d07::buffkitt {
    struct BUFFKITT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUFFKITT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUFFKITT>(arg0, 6, b"BuffKitt", b"Buff Kitty", b"Strong masculine kitty. Strong kitty. Very demure kitty.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_A_handsome_muscular_kitty_cat_with_a_humanoid_3_5db3deeee2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUFFKITT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUFFKITT>>(v1);
    }

    // decompiled from Move bytecode v6
}

