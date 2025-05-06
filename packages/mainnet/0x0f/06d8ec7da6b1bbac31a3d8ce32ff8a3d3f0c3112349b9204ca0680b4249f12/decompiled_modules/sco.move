module 0xf06d8ec7da6b1bbac31a3d8ce32ff8a3d3f0c3112349b9204ca0680b4249f12::sco {
    struct SCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCO>(arg0, 9, b"SCO", b"scorp22", b"poison", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/71d43b0bfd418500c4991630eae80803blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

