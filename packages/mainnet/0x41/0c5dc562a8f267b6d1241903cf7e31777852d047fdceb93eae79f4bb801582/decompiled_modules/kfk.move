module 0x410c5dc562a8f267b6d1241903cf7e31777852d047fdceb93eae79f4bb801582::kfk {
    struct KFK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KFK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KFK>(arg0, 6, b"KFK", b"Kung Fu Kangaroo", b"Kung Fu Kangaroo: The memecoin kicking it on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kungfu_b4f56ad295.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KFK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KFK>>(v1);
    }

    // decompiled from Move bytecode v6
}

