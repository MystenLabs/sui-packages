module 0xf6c37da1c638c5684519601952db960768da923057dc9e13e91075439c7f7d3b::suitify {
    struct SUITIFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITIFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITIFY>(arg0, 6, b"SUITIFY", b"Suitify", x"5375697469667920697320536f756e64204d6f6e65790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_2024_10_10_T170047_042_e26737a40b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITIFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITIFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

