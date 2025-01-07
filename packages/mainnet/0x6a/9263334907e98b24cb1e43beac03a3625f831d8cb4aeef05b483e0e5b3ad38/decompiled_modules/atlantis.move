module 0x6a9263334907e98b24cb1e43beac03a3625f831d8cb4aeef05b483e0e5b3ad38::atlantis {
    struct ATLANTIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATLANTIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATLANTIS>(arg0, 6, b"ATLANTIS", b"Atlantis", b"In the ocean of SUI, remains the Atlantis", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Atlantis_PP_01fa177e67.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATLANTIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATLANTIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

