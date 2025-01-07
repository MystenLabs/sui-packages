module 0x5761893b001f7342bee39e9c52833167ce96f2f6b6649d3dd362e6561a15de88::bsol {
    struct BSOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSOL>(arg0, 9, b"BSOL", b"Foreign token represent BlazeStake Staked SOL", b"Foreign token represent BlazeStake Staked SOL", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

