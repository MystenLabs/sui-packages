module 0x8800de43d1272d1db82c9f3daa144d910d27f6e90fe525489c2d8eb44cbdc78e::pododothedogs {
    struct PODODOTHEDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PODODOTHEDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PODODOTHEDOGS>(arg0, 6, b"PododoTheDogs", b"PododoThe Dogonsui", x"506f646f646f2054686520446f6773206672656520746f6b656e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_22_11_37_59_acaa9a3096.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PODODOTHEDOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PODODOTHEDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

