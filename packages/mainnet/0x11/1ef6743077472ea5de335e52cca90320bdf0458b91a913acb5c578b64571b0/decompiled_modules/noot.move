module 0x111ef6743077472ea5de335e52cca90320bdf0458b91a913acb5c578b64571b0::noot {
    struct NOOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOOT>(arg0, 6, b"NOOT", b"Noot", b"Noot on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000035559_5c236dc1eb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

