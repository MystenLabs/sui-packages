module 0x1f596cf96a7b508e2f3250c98e203926ad6e0acac9e142b12795b252b8e56ee6::PepeArmy {
    struct PEPEARMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEARMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEARMY>(arg0, 6, b"$PEPEARMY", b"Pepe Army Token", b"TG : https://t.me/pepearmy_sui , Website: https://pepearmy.online/ ", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPEARMY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEARMY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

