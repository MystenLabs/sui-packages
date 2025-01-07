module 0xfb272bb8d218f63b5a7e21c23204368a388e5bd02e188c12819cb42e1364c434::ic {
    struct IC has drop {
        dummy_field: bool,
    }

    fun init(arg0: IC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IC>(arg0, 9, b"IC", b"ICE", b"ice token is a good bull run token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/945eb977-4ecf-4c50-9ac9-e3941c7d9907.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IC>>(v1);
    }

    // decompiled from Move bytecode v6
}

