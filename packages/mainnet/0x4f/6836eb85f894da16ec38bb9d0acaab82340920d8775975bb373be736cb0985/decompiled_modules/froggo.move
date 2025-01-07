module 0x4f6836eb85f894da16ec38bb9d0acaab82340920d8775975bb373be736cb0985::froggo {
    struct FROGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGGO>(arg0, 6, b"FROGGO", b"FROGGO FREN", b"It all started when Pepes best friend, Froggo the Dog, got bored of sitting by the swamp. Froggo wanted to have more fun, so he joined Pepe in the world of memes! Together, they created $Froggo, a token full of excitement and play", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/froggo_d68fbf5a51.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

