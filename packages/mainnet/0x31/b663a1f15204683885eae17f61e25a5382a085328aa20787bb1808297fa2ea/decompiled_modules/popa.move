module 0x31b663a1f15204683885eae17f61e25a5382a085328aa20787bb1808297fa2ea::popa {
    struct POPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<POPA>(arg0, 6, 0x1::string::utf8(b"POPA"), 0x1::string::utf8(b"POPA"), 0x1::string::utf8(b"Everything else in crypto is already ass. We just made it official. $POPA on Sui."), 0x1::string::utf8(b"https://popularsui.xyz/media/75a783d3a87cf425849b891080cb5c930c74032458d8ec2c897c78f9b952a358.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<POPA>>(0x2::coin_registry::finalize<POPA>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

