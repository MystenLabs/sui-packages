module 0x60912e0612c2b89a8c227e0ec7e51237c58bb99e239aa88f3d8b108bca647504::whygay {
    struct WHYGAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHYGAY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<WHYGAY>(arg0, 3028178367178822293, b"Gay", b"whygay", b"Don't be gay", b"https://images.hop.ag/ipfs/Qmep3yhK8H9nr1y3bXeH5GZGpUuMN9dVnQuXws6AxDkC3Q", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

