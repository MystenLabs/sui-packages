module 0x4d83db80985d0d048d3a69616ec7a89dd55923d2fbc107bc97e87f2a708c5823::suika {
    struct SUIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKA>(arg0, 6, b"SUIKA", b"SUIKACHU", b"SUIKACHU the wettest coin on SUI! What do you get when you mix water and electricity, SUIKACHU!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7980451_89607c1e2b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

