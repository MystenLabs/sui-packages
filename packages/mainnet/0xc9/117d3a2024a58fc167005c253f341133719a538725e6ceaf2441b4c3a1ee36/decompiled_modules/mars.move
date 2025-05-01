module 0xc9117d3a2024a58fc167005c253f341133719a538725e6ceaf2441b4c3a1ee36::mars {
    struct MARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<MARS>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<MARS>(arg0, b"MARS", b"Planet MARS", b"MARS is the four planet from the Sun and the only astronomical object known to harbor life. This is enabled by Earth being an ocean world, the only one in the Solar System sustaining liquid surface water.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQzatrXtSQRbaajQo3u9WQrDgiHX3WjHT3516JpFLa4A6")), b"https://en.wikipedia.org/wiki/MARS", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"004f56a28248e8a8e800b141cc77bff463203417beed911248b956f4e329c729eedc655d407373aed21a9fbb8c2ea9676b2e67395293c22b845bfc3b0e73f89505ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1746097701"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

