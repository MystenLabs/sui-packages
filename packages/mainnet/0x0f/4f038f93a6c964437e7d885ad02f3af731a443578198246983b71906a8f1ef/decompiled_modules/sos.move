module 0xf4f038f93a6c964437e7d885ad02f3af731a443578198246983b71906a8f1ef::sos {
    struct SOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOS>(arg0, 9, b"SOS", b"SquidOnSui", b"Squid Game 2 AI on Sui OFFICIAL , ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/bc587a30-da3d-11ef-80e8-811f7f414973")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOS>>(v1);
        0x2::coin::mint_and_transfer<SOS>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

