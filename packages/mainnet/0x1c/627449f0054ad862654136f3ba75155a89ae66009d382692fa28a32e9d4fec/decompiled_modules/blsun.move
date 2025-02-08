module 0x1c627449f0054ad862654136f3ba75155a89ae66009d382692fa28a32e9d4fec::blsun {
    struct BLSUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLSUN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<BLSUN>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<BLSUN>(arg0, b"BlSun", b"Blue White Sun", b"Blue White Sun one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cf.hiphop.fun/icon/fedea465-e0f2-442b-9803-707dc2753164")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0079b35e9b8278b61b5a8ada11be42c89dee6bbee4c762bc4a83788a47cb63e2eb7f052bf140fe5675205c4e8dfd0d3cdf7146234a6d7f06fc8f5ea31b8624c10ef5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631739024304"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

