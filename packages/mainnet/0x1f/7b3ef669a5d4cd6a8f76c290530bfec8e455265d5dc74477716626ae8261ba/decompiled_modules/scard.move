module 0x1f7b3ef669a5d4cd6a8f76c290530bfec8e455265d5dc74477716626ae8261ba::scard {
    struct SCARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCARD, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SCARD>(arg0, 3332535640250997380, b"Sui Magic Card", b"SCARD", b"a mysterious and magical card born on Sui network!", b"https://images.hop.ag/ipfs/QmaiTix3Atb1UgL66NWrZtgA298ScWbuZ9xWrfqiX3kkDe", 0x1::string::utf8(b"https://x.com/SuiMagicCard"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/pachopsui"), arg1);
    }

    // decompiled from Move bytecode v6
}

