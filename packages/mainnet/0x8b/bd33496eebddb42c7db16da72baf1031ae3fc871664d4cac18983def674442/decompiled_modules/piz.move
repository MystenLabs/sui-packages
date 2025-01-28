module 0x8bbd33496eebddb42c7db16da72baf1031ae3fc871664d4cac18983def674442::piz {
    struct PIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIZ, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<PIZ>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<PIZ>(arg0, b"PIZ", b"Pizza", b"THE Pizza", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/73b352da-1c61-4878-9074-94ae5c308aa3")), b"https://pizza.com/", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00686c54ac54cf7c693e2a581c56f48511f6c307714dd3fd8714de614e07fe45063a620e8dfe03e1647e0ac69cea58dbbdf36f78c7bf3dace9b03a09489fc00f02f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631738055853"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

