module 0xac45abe2e5a7506d57f3ea94f6c5773a3b0f98d60cadf1f02367ef4e836ba21a::pg {
    struct PG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PG>(arg0, 9, b"PG", b"PubG", b"For gaming token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/35177011-be16-41be-8fa1-55b84f66f5ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PG>>(v1);
    }

    // decompiled from Move bytecode v6
}

