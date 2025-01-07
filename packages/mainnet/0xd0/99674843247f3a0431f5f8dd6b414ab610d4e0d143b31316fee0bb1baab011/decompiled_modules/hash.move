module 0xd099674843247f3a0431f5f8dd6b414ab610d4e0d143b31316fee0bb1baab011::hash {
    struct HASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HASH>(arg0, 9, b"HASH", b"Memhash", b"Memhash is a mining-based game where you can mining token by utilizing your device processing power. The mining algorithm follos the similar principles as Bitcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b00c9024fba324e5fbc01a423a2b24c9blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HASH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HASH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

