module 0xa051af41e3f7ac3377bc3b4df6b4221f4b451d114755bce700bc4c8378cf23b3::prs {
    struct PRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRS>(arg0, 9, b"PRS", b"paris in summer", b"new token sui paris in the summer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/17f8796126a19098bc03849f10952048blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

