module 0x18451a0b29c9c864cfb5cf27c4c9340861184daeed53e1057e2ed08276b84aef::d {
    struct D has drop {
        dummy_field: bool,
    }

    fun init(arg0: D, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<D>(arg0, 6, b"D", b"DINKAN", b"There is only one  God, and he is a RAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dinkan_1e4edb6640.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<D>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<D>>(v1);
    }

    // decompiled from Move bytecode v6
}

