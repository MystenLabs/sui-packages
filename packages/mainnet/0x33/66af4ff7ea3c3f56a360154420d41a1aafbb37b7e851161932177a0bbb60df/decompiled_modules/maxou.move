module 0x3366af4ff7ea3c3f56a360154420d41a1aafbb37b7e851161932177a0bbb60df::maxou {
    struct MAXOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAXOU, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<MAXOU>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<MAXOU>(arg0, b"MAXOU", b"MaxCoin", x"546865206f6e6c7920746f6b656e20746861742063616e206d656c7420676c61636965727320616e64207761726d20757020796f75722077616c6c65742e20244d41584f5520e2809420746865206d656d6520636f696e206d616465206f6e2053554920666f72206c6f76657273206f66206c6f76652c206c61756768732c20616e64207368696e7920676f6c642072696e67732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmd3jsL6LdHovmC6UK56Ns7m2WmFy17JsJuQfHEC2SMtjM")), b"WEBSITE", b"https://x.com/sui_maxou", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0036499cc7a04ebe0bba1abe6b03bbfc766e3d9fecfa08a0f1c36164e1ba15f50499dfff19f7be4589698d2b0f56823b87b571b8ac56d74e173e93341dfdea2e03d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747760524"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

