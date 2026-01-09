module 0x1199820bbd039940dce9b65e3e2832180650b7f4339ba7b60daac8f9946bfb36::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<USDC>(arg0, 6, 0x1::string::utf8(b"USDC"), 0x1::string::utf8(b"USD Coin"), 0x1::string::utf8(b"USDC for test claim referral"), 0x1::string::utf8(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmbRRalBmGfhMfBqTVsUYkQanLmkvbXzpe9w&s"), arg1);
        let v2 = v1;
        0x2::transfer::public_freeze_object<0x2::coin_registry::MetadataCap<USDC>>(0x2::coin_registry::finalize<USDC>(v0, arg1));
        0x2::coin::mint_and_transfer<USDC>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

