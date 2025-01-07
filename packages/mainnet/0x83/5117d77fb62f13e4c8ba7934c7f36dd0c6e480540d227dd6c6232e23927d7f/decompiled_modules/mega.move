module 0x835117d77fb62f13e4c8ba7934c7f36dd0c6e480540d227dd6c6232e23927d7f::mega {
    struct MEGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEGA>(arg0, 6, b"MEGA", b"MEGUSTA", x"4d454755535441205447202d2032306b0a4d454755535441205457202d203130306b0a4d4547555354412053495445202d203530306b200a5245464552414c2053595354454d20414e44205354414b494e47203e3e3e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5b86f80ed098d_7c347da6c8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

