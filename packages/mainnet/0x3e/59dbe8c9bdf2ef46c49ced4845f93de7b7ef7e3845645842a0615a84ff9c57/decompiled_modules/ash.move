module 0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::ash {
    struct ASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASH>(arg0, 9, b"ASH", b"Ash", b" Reward token for the SuiBurn protocol. Burn SUI, rise from the ASH.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suiburn.com/logos/cdn-ash.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

