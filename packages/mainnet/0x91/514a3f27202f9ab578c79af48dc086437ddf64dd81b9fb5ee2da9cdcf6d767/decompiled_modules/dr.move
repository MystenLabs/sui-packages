module 0x91514a3f27202f9ab578c79af48dc086437ddf64dd81b9fb5ee2da9cdcf6d767::dr {
    struct DR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DR>(arg0, 9, b"DR", b"Dyor", b"For fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5af0874f-e275-44a2-a4f9-06092169944d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DR>>(v1);
    }

    // decompiled from Move bytecode v6
}

