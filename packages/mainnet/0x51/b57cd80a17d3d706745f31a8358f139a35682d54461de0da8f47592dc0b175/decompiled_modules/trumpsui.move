module 0x51b57cd80a17d3d706745f31a8358f139a35682d54461de0da8f47592dc0b175::trumpsui {
    struct TRUMPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPSUI>(arg0, 6, b"TRUMPSUI", b"Trump on SUI ", x"4d616b696e6720686973746f72792c206e6f7720612050726f43727970746f2072756c65732c2074686973206d656d6520726570726573656e7473207468652070656f706c652077686f206172652068617070792c2062656361757365206f6620746865206368616e6765206974206d65616e7320666f722074686520656e746972652065636f73797374656d2e0a4e6f772074686520726567756c6174696f6e732077696c6c20776f726b20696e206f7572206661766f722c20746865206d656d65732072756c6520616e642077696c6c2072756c652074686520776f726c642e2e2050554d5020616e642046554e2121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731492851372.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

