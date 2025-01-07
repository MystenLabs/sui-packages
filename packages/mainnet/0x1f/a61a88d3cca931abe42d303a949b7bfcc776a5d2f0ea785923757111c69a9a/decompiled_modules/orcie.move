module 0x1fa61a88d3cca931abe42d303a949b7bfcc776a5d2f0ea785923757111c69a9a::orcie {
    struct ORCIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORCIE>(arg0, 6, b"ORCIE", b"Orcie", b"$ORCIE Here to make a Splash on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Y_Oxoz_Mu_T_400x400_28ea94a2c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORCIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORCIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

