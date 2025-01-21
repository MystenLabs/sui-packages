module 0xf09391beb38646a1d505ccdcc117ccee01edb1373ea3fe722bbc2995bde0ba1e::suishi {
    struct SUISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHI>(arg0, 6, b"SUISHI", b"SUIShibba", x"546865206c6f79616c20636f6d70616e696f6e206f66205355492e20466f7267657420446f67652c2068657265e280997320796f75722053554970657220646f67210a4261726b696e672075702074686520626c6f636b636861696e20747265652077697468205355495368696261210a2020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737440886802.58")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

