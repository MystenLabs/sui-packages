module 0xdc75bbe0643b7d295667f642fcce49d084ab0ec1a378a02ca1eac6e37379d2d2::nis {
    struct NIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIS>(arg0, 7, b"NIS", b"Noise", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/33ec94f0-d8a9-11ef-aa91-a3ba71e0e083")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIS>>(v1);
        0x2::coin::mint_and_transfer<NIS>(&mut v2, 11000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

