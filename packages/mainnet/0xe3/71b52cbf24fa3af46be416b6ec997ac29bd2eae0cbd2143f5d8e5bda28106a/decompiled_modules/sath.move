module 0xe371b52cbf24fa3af46be416b6ec997ac29bd2eae0cbd2143f5d8e5bda28106a::sath {
    struct SATH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATH>(arg0, 8, b"SATH", b"SuiAthCelebrationCoin", b"gemaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9B0OiJPPfYUelLHBPkrNaSCNrLsE2U6MHVQ&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SATH>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATH>>(v1);
    }

    // decompiled from Move bytecode v6
}

