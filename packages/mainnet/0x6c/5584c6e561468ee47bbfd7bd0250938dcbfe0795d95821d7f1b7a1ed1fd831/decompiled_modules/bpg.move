module 0x6c5584c6e561468ee47bbfd7bd0250938dcbfe0795d95821d7f1b7a1ed1fd831::bpg {
    struct BPG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPG>(arg0, 9, b"BPG", b"BigPig", b"Hot Big Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e0144c7a-0176-4d45-9c8a-6cfd70c4762f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BPG>>(v1);
    }

    // decompiled from Move bytecode v6
}

