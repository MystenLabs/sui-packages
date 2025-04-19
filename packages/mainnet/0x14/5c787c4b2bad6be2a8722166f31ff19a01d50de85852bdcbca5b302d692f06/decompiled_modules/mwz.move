module 0x145c787c4b2bad6be2a8722166f31ff19a01d50de85852bdcbca5b302d692f06::mwz {
    struct MWZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MWZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MWZ>(arg0, 9, b"Mwz", b"mewazin", b"trust me bro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d1e469b6120f79367702a77d825e7577blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MWZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MWZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

