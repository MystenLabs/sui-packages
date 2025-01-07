module 0x9358168209ae55d1d908b4b74fc5db5aa5bbdb7b09e17220eb2b3accd2c4d2b::meemeews {
    struct MEEMEEWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEEMEEWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEEMEEWS>(arg0, 9, b"MEEMEEWS", b"MEME ON SUI", b"MEEMEEWS On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be-alpha.7k.fun/api/file-upload/60d5fa9e54e8fa9ac3618b853cacd651blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEEMEEWS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEEMEEWS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

