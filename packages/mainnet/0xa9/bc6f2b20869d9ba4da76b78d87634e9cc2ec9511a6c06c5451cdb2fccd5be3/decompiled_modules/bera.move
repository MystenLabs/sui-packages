module 0xa9bc6f2b20869d9ba4da76b78d87634e9cc2ec9511a6c06c5451cdb2fccd5be3::bera {
    struct BERA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BERA>(arg0, 9, b"BERA", b"Berachain Foundation", x"466972737420416e2045564d206964656e746963616c204c31206f6e205355492c20616c69676e696e6720736563757269747920616e64206c6971756964697479207468726f7567682050726f6f66206f66204c69717569646974792e200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f6f87e6748d6bced7a70cf45e79b5620blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BERA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

