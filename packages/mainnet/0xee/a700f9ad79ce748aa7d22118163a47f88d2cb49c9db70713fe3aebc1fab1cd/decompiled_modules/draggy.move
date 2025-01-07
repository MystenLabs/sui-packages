module 0xeea700f9ad79ce748aa7d22118163a47f88d2cb49c9db70713fe3aebc1fab1cd::draggy {
    struct DRAGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGGY>(arg0, 6, b"DRAGGY", b"Sui Draggy", x"53756974656420757020616e64207361766f72696e6720737563636573732c207768656e20796f75e28099726520776974682024445241474759202c20796f752063656c656272617465206c696b65206120626f73732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731191314578.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRAGGY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGGY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

