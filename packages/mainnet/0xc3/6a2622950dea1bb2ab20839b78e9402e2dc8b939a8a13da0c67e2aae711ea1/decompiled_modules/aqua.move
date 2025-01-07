module 0xc36a2622950dea1bb2ab20839b78e9402e2dc8b939a8a13da0c67e2aae711ea1::aqua {
    struct AQUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUA, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<AQUA>(arg0, 6410309790885308741, b"Aqua", b"AQUA", x"41717561206973206120706c617966756c20616e6420637265617469766520636f6e63657074207468617420647261777320696e737069726174696f6e0a66726f6d2074686520706f70756c617220616e696d652073657269657320224b6f6e6f537562613a20476f64277320426c657373696e67206f6e0a5468697320576f6e64657266756c20576f726c642122", b"https://images.hop.ag/ipfs/Qmag8e2szLdzb7eMCFzhBMLZESFnrTc9edxxyEsMTqqAch", 0x1::string::utf8(b"https://x.com/AQUA_on_Sui"), 0x1::string::utf8(b"https://aquasui.xyz/"), 0x1::string::utf8(b"https://t.me/aquasuiportal"), arg1);
    }

    // decompiled from Move bytecode v6
}

