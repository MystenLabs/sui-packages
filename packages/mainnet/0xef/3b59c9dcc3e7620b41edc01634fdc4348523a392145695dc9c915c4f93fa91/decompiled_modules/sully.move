module 0xef3b59c9dcc3e7620b41edc01634fdc4348523a392145695dc9c915c4f93fa91::sully {
    struct SULLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SULLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SULLY>(arg0, 6, b"SULLY", b"Sulley On Sui", b"Sulley is bringing the joy of Christmas to the crypto world! Inspired by the lovable blue monster from Monster Inc.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_5_971a9b6b8a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SULLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SULLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

