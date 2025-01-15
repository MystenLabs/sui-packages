module 0xd36b43b5b3e681e77e09ed9a9952d8073d05048eabe6e557a96cc61b99f208cf::abcabc {
    struct ABCABC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABCABC, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<ABCABC>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<ABCABC>(arg0, b"ABCABC", b"ABC", b"abcabc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/949c5e69-53b6-4e59-95fd-fb1d34811d19")), b"WWW.BAIDU.COM", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0005fff290e90e51d5316e6d80680fc51c8e31ee33b9f759689d6df864661a4364dfabe9155749dde644e1582e3e77cef5ff912282c42bcfb442e51bdfb33ccd0ef5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631736933522"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

