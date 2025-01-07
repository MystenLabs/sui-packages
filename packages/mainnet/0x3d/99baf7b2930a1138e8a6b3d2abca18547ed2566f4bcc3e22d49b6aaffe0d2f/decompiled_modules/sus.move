module 0x3d99baf7b2930a1138e8a6b3d2abca18547ed2566f4bcc3e22d49b6aaffe0d2f::sus {
    struct SUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUS>(arg0, 9, b"SUS", b"SuSui", b"Crewmate or Impostor?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/LQ0DYLd.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

