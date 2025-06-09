module 0x8673226d2806317a30de96823efda31f650c39cdae56fa37a13e5cb802e3bd5a::caes {
    struct CAES has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAES>(arg0, 6, b"CAES", b"Caesuius", b"Empowering the Future on Sui Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig2j2cs72iafnog7uttik63jlaykvyzrdqu23mbquwinximpmhvee")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CAES>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

