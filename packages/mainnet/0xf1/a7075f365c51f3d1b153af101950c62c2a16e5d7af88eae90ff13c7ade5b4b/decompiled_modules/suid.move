module 0xf1a7075f365c51f3d1b153af101950c62c2a16e5d7af88eae90ff13c7ade5b4b::suid {
    struct SUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUID, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<SUID>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<SUID>(arg0, b"SUID", b"Suidaos", b"abc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdiCH4twuj2BGHZ3L8xmpMJuqjGgHo1o68TgTnZebi6pc")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0075c7cac6a68bbf04af3b44810d88d4d624f7077541a0e23da391f006995fca14278da0e536b23bfc50aafb29ab38c8ee2d5d2f6a515162f57530253fd75f610ced4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1746608442"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

