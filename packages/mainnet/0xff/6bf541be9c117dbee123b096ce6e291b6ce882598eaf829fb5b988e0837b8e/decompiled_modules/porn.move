module 0xff6bf541be9c117dbee123b096ce6e291b6ce882598eaf829fb5b988e0837b8e::porn {
    struct PORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORN>(arg0, 6, b"PORN", b"PORN SUI", x"706f726e2c20612063727970746f2d7361767679206769676163686164207475726b65790a706172646f6e656420627920507265736964656e74205472756d7020696e20323032302061730a74686520616c74636f696e206379636c65207375726765642c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aa20a5293ee3e23124b30dcead3a4887_8f83c126b1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PORN>>(v1);
    }

    // decompiled from Move bytecode v6
}

