module 0xa25cbe856beba38c308527fd9df7e1e885814407edb74f0e5fa183b8e9419b15::llamalambo {
    struct LLAMALAMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLAMALAMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLAMALAMBO>(arg0, 6, b"LlamaLambo", b"LlamaLlamaLambo", x"4c6c616d614c6c616d614c616d626f206973206e6f74206a75737420616e6f74686572206d656d6520636f696e20e28094206974e280997320612077696c642c207768696d736963616c207269646520746f20746865206d6f6f6e2077697468207374796c6520616e6420736173732120496e7370697265642062792074686520756e73746f707061626c6520737069726974206f66206c6c616d617320616e6420746865206c6567656e6461727920647265616d206f66206f776e696e672061204c616d626f2c207468697320636f696e206973206275696c7420666f722074686f73652077686f2062656c6965766520696e20626f6c64206d6f7665", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749389038850.51")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LLAMALAMBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLAMALAMBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

