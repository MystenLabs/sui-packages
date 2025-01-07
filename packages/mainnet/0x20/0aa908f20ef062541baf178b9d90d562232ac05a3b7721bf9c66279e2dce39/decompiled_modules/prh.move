module 0x200aa908f20ef062541baf178b9d90d562232ac05a3b7721bf9c66279e2dce39::prh {
    struct PRH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRH>(arg0, 9, b"PRH", b"Piran Hypeee", x"4120467265616b696e67204e61756768747920506972616e686120696e2074686520537569204f6365616e20f09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1bf10453ca3313a8e0aa1a5886ae9866blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

