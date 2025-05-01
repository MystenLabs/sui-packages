module 0xdcd8a5054262bb474f8cca257551f81197ae2935e93dbc0cb36ad80b00f44c5b::mars {
    struct MARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<MARS>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<MARS>(arg0, b"MARS", b"Planet MARS", b"MARS is the four planet from the Sun and the only astronomical object known to harbor life. This is enabled by Earth being an ocean world, the only one in the Solar System sustaining liquid surface water.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQzatrXtSQRbaajQo3u9WQrDgiHX3WjHT3516JpFLa4A6")), b"https://en.wikipedia.org/wiki/MARS", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0078f8653d95f428b19fa8761e9b64992ef258d793f4d71329778cad45ad3c496f2d6d28944f5f2a1a3632ad93289300be1ae6281430c255c782b45dbaabad170bed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1746098139"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

