module 0xe3334e651f55eaa63bff9d02ee395cf526d024a67d36974a05d0feefee3e0206::penguin {
    struct PENGUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGUIN>(arg0, 6, b"PENGUIN", b"Penguin", b"Penguin is the most brutal on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_08_11_T235746_465_eab068248c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGUIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGUIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

