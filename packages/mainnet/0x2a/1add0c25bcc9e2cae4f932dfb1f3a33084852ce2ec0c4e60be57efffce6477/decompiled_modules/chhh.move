module 0x2a1add0c25bcc9e2cae4f932dfb1f3a33084852ce2ec0c4e60be57efffce6477::chhh {
    struct CHHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHHH, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<CHHH>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<CHHH>(arg0, b"CHHH", b"Chiiil", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/d4f56907-f1b2-4b21-8268-2de8bb4d8bb2")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0049848cf33367addbc48997a99d9a958a2d66b43ff9f9fb8ad49b34ebeee167dc6a3eb59087b73c6951dd7a7ef752ba9f18b3ec377ae8bfeb99f7216a5e63ac0bf5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631738163179"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

