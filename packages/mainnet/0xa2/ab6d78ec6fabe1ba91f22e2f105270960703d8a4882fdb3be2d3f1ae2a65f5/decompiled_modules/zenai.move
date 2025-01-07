module 0xa2ab6d78ec6fabe1ba91f22e2f105270960703d8a4882fdb3be2d3f1ae2a65f5::zenai {
    struct ZENAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZENAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZENAI>(arg0, 9, b"ZENAI", b"The ZenAi", b"Ai using zen to master the crypto markets...... #Zenai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6eada667f268b57d91739ba8a427ffdablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZENAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZENAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

