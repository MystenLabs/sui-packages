module 0x4c387d6e0520a3d9ff466e7e3fd604c2efcc3de05619cd069298ea00f13e8f84::btrump {
    struct BTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTRUMP>(arg0, 6, b"BTRUMP", b"Baby Trump", b"Official Baby Trump On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026965_bbfddeb825.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

